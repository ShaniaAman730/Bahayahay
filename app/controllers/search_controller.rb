class SearchController < ApplicationController
  def index
    @query = params[:q]
    @filter = params[:filter]
    @results = []

    return unless @query.present?

    # REALTY FILTER
    if @filter == "realty"
      @results = Realty.where("name ILIKE :q OR business_location ILIKE :q", q: "%#{@query}%")

    # REBAP FILTER 
    elsif @filter == "rebap"
      rebap_chapters = RebapMembership
        .includes(:rebap)
        .where("chapter ILIKE :q", q: "%#{@query}%")
        .map(&:rebap)
      @results = rebap_chapters

    # REALTOR / DEVELOPER FILTERS
    else
      users = User.searchable(@query)

      case @filter
      when "realtor"
        users = users.realtor
      when "developer"
        users = users.developer
      end

      @results += users

      # Add realties only when no specific filter is applied (All)
      if @filter.blank?
        realties = Realty.where("name ILIKE :q OR business_location ILIKE :q", q: "%#{@query}%")
        @results += realties
      end

      # Add REBAP chapters only when no specific filter is applied (All)
      if @filter.blank?
        rebap_chapters = RebapMembership
          .includes(:rebap)
          .where("chapter ILIKE :q", q: "%#{@query}%")
          .map(&:rebap)
        @results += rebap_chapters
      end
    end

    @results = Kaminari.paginate_array(@results.uniq).page(params[:page]).per(10)
  end
end
