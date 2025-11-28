class LessonsController < ApplicationController
  before_action :require_login
  before_action :set_lesson, only: [:mark_attendance, :mark_absence]
  before_action :authorize_user!, only: [:mark_attendance, :mark_absence]

  def mark_attendance
    if @lesson.update(is_attendance: 1, absence_reason: nil)
      render json: { ok: true, lesson: @lesson.slice('id','is_attendance','absence_reason') }
    else
      render json: { ok: false, errors: @lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def mark_absence
    reason = params[:reason].to_s.strip
    if @lesson.update(is_attendance: 2, absence_reason: reason.presence)
      render json: { ok: true, lesson: @lesson.slice('id','is_attendance','absence_reason') }
    else
      render json: { ok: false, errors: @lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def authorize_user!
    # 管理者は全許可、本人のみ更新可能、といったルール例
    unless current_user.admin? || current_user == @lesson.user
      head :forbidden
    end
  end
end
