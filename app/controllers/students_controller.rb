class StudentsController < ApplicationController
  before_action :require_login

  # GET /students/:id/timetable
  def timetable
    @student = User.find_by(id: params[:id], role: 'student')
    return head :not_found unless @student
    return head :forbidden unless current_user.admin? || current_user == @student

    @days = %w[日 月 火 水 木 金 土]
    start_of_week = Date.today.beginning_of_week(:monday)
    @week_days = (0..6).map { |i| start_of_week + i }

    @lessons = if @student.respond_to?(:lessons)
                 @student.lessons.where(date: @week_days.first..@week_days.last)
                         .order(date: :asc, period_number: :asc)
               else
                 Lesson.none
               end

    # render the same wrapper partial used by home#index so the "current_student" line is preserved
    render partial: 'home/lessons_container', locals: { lessons: @lessons, student: @student }
  end
end