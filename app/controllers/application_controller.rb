class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?
  before_action :load_students

  private

  def load_students
    return unless logged_in? && current_user&.admin?
    @students = User.where(role: 'student').select(:id, :student_no, :name).distinct.order(:student_no)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to login_path unless logged_in?
  end

end
