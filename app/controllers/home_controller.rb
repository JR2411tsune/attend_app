require 'date'

class HomeController < ApplicationController
  before_action :require_login
  def index
    @days = ["日", "月", "火", "水", "木", "金", "土"]
    today = Date.today - 14
    @week_days = today.beginning_of_week(:monday)..today.end_of_week(:monday)

    @lessons = if current_user.respond_to?(:lessons)
                  current_user.lessons.where(date: @week_days).order(:date, :period_number)
                else
                  Lesson.none
                end
  end

  # 非同期用：指定週の時間割 partial を返す
  def week
    @days = ["日", "月", "火", "水", "木", "金", "土"]
    start_date = params[:start].present? ? Date.parse(params[:start]) : Date.today.beginning_of_week(:monday)
    @week_days = (0..6).map { |i| start_date + i }

    if params[:student_id].present? && current_user.admin?
      student = User.find_by(id: params[:student_id], role: 'student')
      @lessons = student ? student.lessons.where(date: @week_days.first..@week_days.last).order(date: :asc, period_number: :asc) : Lesson.none
    else
      @lessons = current_user.respond_to?(:lessons) ? current_user.lessons.where(date: @week_days.first..@week_days.last).order(date: :asc, period_number: :asc) : Lesson.none
    end

    render partial: 'home/lessons_table', locals: { lessons: @lessons }
  end

  def task1_7
  end

  def task2_4
  end
end
