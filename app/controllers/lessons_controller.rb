class LessonsController < ApplicationController
  before_action :require_login
  before_action :set_lesson, only: [:mark_attendance, :mark_absence, :mark_none]
  before_action :authorize_user!, only: [:mark_attendance, :mark_absence, :mark_none]

  # 学生が「出席」を押した / 管理者の「出席にする」
  def mark_attendance
    if @lesson.update(is_attendance: 1, absence_reason: nil)
      render json: { ok: true, lesson: @lesson.as_json(only: [:id, :is_attendance, :absence_reason]) }
    else
      render json: { ok: false, errors: @lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 学生が欠席確定 or 管理者の「欠席にする」
  def mark_absence
    reason = params[:reason].to_s.strip
    if reason.blank?
      render json: { ok: false, errors: ['欠席理由は必須です'] }, status: :unprocessable_entity
      return
    end

    if @lesson.update(is_attendance: 2, absence_reason: reason)
      render json: { ok: true, lesson: @lesson.as_json(only: [:id, :is_attendance, :absence_reason]) }
    else
      render json: { ok: false, errors: @lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 管理者の「無効にする」(出欠をリセット)
  def mark_none
    if @lesson.update(is_attendance: 0, absence_reason: nil)
      render json: { ok: true, lesson: @lesson.as_json(only: [:id, :is_attendance, :absence_reason]) }
    else
      render json: { ok: false, errors: @lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find_by(id: params[:id])
    return head :not_found unless @lesson
  end

  def authorize_user!
    return if current_user&.admin?
    unless current_user == @lesson.user
      head :forbidden
    end
  end
end
