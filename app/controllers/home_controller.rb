require 'date'

class HomeController < ApplicationController
  before_action :require_login

  def index
    @days = %w[日 月 火 水 木 金 土]
    start_of_week = Date.today.beginning_of_week(:monday)
    @week_days = (0..6).map { |i| start_of_week + i }

    if current_user.admin?
      # 初期表示：students の最初の生徒（任意ロジックに変更可）
      @display_student = @students&.first
    else
      @display_student = current_user
    end

    @lessons = if @display_student && @display_student.respond_to?(:lessons)
                 @display_student.lessons.where(date: @week_days.first..@week_days.last).order(date: :asc, period_number: :asc)
               else
                 Lesson.none
               end
  end

  # 非同期用：指定週の時間割 partial を返す
  def week
    @days = ["日", "月", "火", "水", "木", "金", "土"]
    start_date = params[:start].present? ? Date.parse(params[:start]) : Date.today.beginning_of_week(:monday)
    @week_days = (0..6).map { |i| start_date + i }

    display_student = nil
    if params[:student_id].present? && current_user.admin?
      display_student = User.find_by(id: params[:student_id], role: 'student')
      @lessons = display_student ? display_student.lessons.where(date: @week_days.first..@week_days.last).order(date: :asc, period_number: :asc) : Lesson.none
    else
      display_student = current_user
      @lessons = current_user.respond_to?(:lessons) ? current_user.lessons.where(date: @week_days.first..@week_days.last).order(date: :asc, period_number: :asc) : Lesson.none
    end

    render partial: 'home/lessons_container', locals: { lessons: @lessons, student: display_student }
  end

  def task1_7
  end

  def task2_4
    @sumples = Testsumple.all
    @total_attendance =  @sumples.where(status: "present").count
    @total_absence = @sumples.where(status: "absent").count

    @timelimit_h_1 = Time.now.hour == 9
    @timelimit_m_1 = Time.now.min >=25 && Time.now.min <=30

    @timelimit_h_2 = Time.now.hour == 11
    @timelimit_m_2 = Time.now.min >=15 && Time.now.min <=20

    @timelimit_h_3 = Time.now.hour == 13  
    @timelimit_m_3 = Time.now.min >=40 && Time.now.min <=45

  end

  def add_attendance
    Testsumple.create(status: params[:status])
    redirect_to home_task2_4_path, notice: "出欠席が追加されました。"
  end
end
