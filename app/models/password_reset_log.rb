class PasswordResetLog < ApplicationRecord
  belongs_to :admin, class_name: "User"
  belongs_to :user, class_name: "User"

  validates :new_password, presence: true

  # Simple search method
  def self.search(query)
    if query.present?
      joins(:user).where("users.email ILIKE ? OR users.first_name ILIKE ? OR users.last_name ILIKE ?", 
        "%#{query}%", "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
