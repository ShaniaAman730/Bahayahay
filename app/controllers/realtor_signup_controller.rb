class RealtorSignupController < ApplicationController
  before_action :redirect_if_authenticated

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

 def create
    @user = User.new(user_params) # Use strong parameters for security
    @user.user_type = 2
    if @user.save 
      redirect_to thank_you_realtor_path, notice: "Realtor account created successfully. Please wait for admin approval."
    
    else
      flash[:alert] = "Realtor account could not be created: #{@user.errors.full_messages.join(", ")}"
      render :new # Render the new user form again
    end
end

def thank_you_realtor

end

private 

    def redirect_if_authenticated
      if current_user
        redirect_to root_path, alert: "Please log-out first if you want to set up a Realtor account."
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :contact_no, :address, :company_name, :prc_no, :dhsud_no, :prc_id, :dhsud_cert, :gov_id, :is_broker, :broker_name, :broker_prc_no) 
    end
   


end
