require 'date'

class HomeController < ApplicationController
  before_action :require_login
  def index
    @days = ["日", "月", "火", "水", "木", "金", "土"]
    today = Date.today
    @week_days = today.beginning_of_week(:monday)..today.end_of_week(:monday)
  end

  def task1_7
  end

  def task2_4
  end
end
