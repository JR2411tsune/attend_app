class HomeController < ApplicationController
  def index
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
