class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?
  before_action :load_students

  private

  def load_students
    return unless logged_in? && current_user&.admin?
    # student_no ごとにまとめて、代表となる id を返す（重複行を潰す）
    @students = User.where(role: 'student')
                    .group(:student_no, :name)
                    .select('MIN(id) AS id, student_no, name')
                    .order(:student_no)
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
