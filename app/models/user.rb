class User < ApplicationRecord
  has_secure_password
  has_many :lessons

  def admin?
    role.present? && role == "administrator"
  end
end
