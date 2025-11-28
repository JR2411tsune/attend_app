class StudentsController < ApplicationController
  before_action :require_login

  def timetable
    @student = User.find_by(id: params[:id], role: 'student')

    @days = ["日", "月", "火", "水", "木", "金", "土"]
    today = Date.today - 7
    @week_days = today.beginning_of_week(:monday)..today.end_of_week(:monday)

    @lessons = @student.respond_to?(:lessons) ? @student.lessons.where(date: @week_days).order(:date, :period) : Lesson.none

    render partial: 'students/timetable', locals: { student: @student, lessons: @lessons}