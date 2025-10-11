class RebapMembership < ApplicationRecord
  belongs_to :rebap, class_name: "User"
  belongs_to :member, class_name: "User", optional: true

  validates :chapter, presence: true
  validates :rebap_id, uniqueness: { scope: :member_id }
  validates :order, uniqueness: true, allow_nil: true
  validates :year, presence: true, if: -> { role.present? }

  # If a member is removed, also unassign officer
  before_destroy :unassign_if_officer

  private

  def unassign_if_officer
    update(role: nil, year: nil, order: nil)
  end
end
