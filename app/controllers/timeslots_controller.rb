require 'csv'
class TimeslotsController < ApplicationController
  before_action :require_user_administrator
  def index
    @timeslots = Timeslot.all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_timeslots_csv(@timeslots)
      end
    end
  end
  
  def show
    @timeslot = Timeslot.find(params[:id])
  end
  
  def new
    @timeslot = Timeslot.new
  end
  
  def create
    @timeslot = Timeslot.new(timeslot_params)

    if @timeslot.save
      flash[:success] = '時間枠を登録しました。'
      redirect_to action: 'index'
    else
      flash.now[:danger] = '時間枠の登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @timeslot = Timeslot.find(params[:id])
  end
  
  def update
    @timeslot = Timeslot.find(params[:id])
    if @timeslot.update(timeslot_params)
      flash[:success] = '時間枠 は正常に更新されました'
      redirect_to action: 'index'
    else
      flash.now[:danger] = '時間枠 は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy

    flash[:success] = '時間枠 は正常に削除されました'
    redirect_to action: 'index'
  end
  
  private
  def timeslot_params
    params.require(:timeslot).permit(:day_of_the_week, :time_start, :time_finish)
  end
  
  def send_timeslots_csv(timeslots)
    csv_data = CSV.generate do |csv|
      header = %w(id day_of_the_week time_start time_finish created_at updated_at)
      csv << header
  
      timeslots.each do |timeslot|
        values = [timeslot.id, timeslot.day_of_the_week, timeslot.time_start, timeslot.time_finish, timeslot.created_at, timeslot.updated_at ]
        csv << values
      end
    end
    send_data(csv_data, filename: "timeslots.csv")
  end
end
