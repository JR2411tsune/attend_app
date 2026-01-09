class LessonsController < ApplicationController
  before_action :require_login
  before_action :set_lesson, only: [:mark_attendance, :mark_absence, :mark_none]
  before_action :authorize_user!, only: [:mark_attendance, :mark_absence, :mark_none]

  def mark_attendance
    unless allowed_by_deadline?(@lesson)
      render json: { ok: false, error: '締切を過ぎているため変更できません' }, status: :forbidden and return
    end

    if @lesson.update(is_attendance: 1, absence_reason: nil)
      render json: { ok: true, lesson: @lesson.as_json(only: [:id, :is_attendance, :absence_reason]) }
    else
      render json: { ok: false, errors: @lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def mark_absence
    unless allowed_by_deadline?(@lesson)
      render json: { ok: false, error: '締切を過ぎているため変更できません' }, status: :forbidden and return
    end

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

  # 締切判定：管理者は常に許可。生徒は期日までのみ許可。
  def allowed_by_deadline?(lesson)
    return true if current_user&.admin?

    # period -> [hour, min]
    mapping = {
      1 => [9, 30],
      2 => [11, 20],
      3 => [13, 45]
    }

    period = lesson.period_number.to_i
    date = lesson.date

    cutoff_hm = mapping[period]
    if cutoff_hm
      cutoff = Time.zone.local(date.year, date.month, date.day, cutoff_hm[0], cutoff_hm[1], 0)
    else
      # default: 当日終端まで許可（必要なら変更）
      cutoff = Time.zone.local(date.year, date.month, date.day, 23, 59, 59)
    end

    Time.zone.now <= cutoff
  end
end
