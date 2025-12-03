class User < ApplicationRecord
  has_secure_password
  has_many :lessons

  validates :student_no, uniqueness: true, allow_blank: true

  def admin?
    role.present? && role == "administrator"
  end
end
