require 'csv'

class AllocationsController < ApplicationController
  before_action :require_user_administrator
  
  def index
    @allocations = Allocation.all
    
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_allocations_csv(@allocations)
      end
    end
  end
  
  def show
    @allocation = Allocation.find(params[:id])
    @room = Room.find(id=@allocation.room_id)
    @facility = Facility.find(id=@room.facility_id)
    @timeslot = Timeslot.find(id=@allocation.timeslot_id)
  end
  
  def new
    @allocation = Allocation.new
  end
  
  def create
    @allocation = Allocation.new(allocation_params)

    if @allocation.save
      flash[:success] = '予約枠を登録しました。'
      redirect_to @allocation
    else
      flash.now[:danger] = '予約枠の登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @allocation = Allocation.find(params[:id])
  end
  
  def update
    @allocation = Allocation.find(params[:id])
    if @allocation.update(allocation_params)
      flash[:success] = '予約枠 は正常に更新されました'
      redirect_to  @allocation
    else
      flash.now[:danger] = '予約枠 は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @allocation = Allocation.find(params[:id])
    @allocation.destroy

    flash[:success] = '予約枠 は正常に削除されました'
    redirect_to action: '/room/' + @allocation.room_id.to_s
  end
  
  private

  def allocation_params
    params.require(:allocation).permit(:room_id, :timeslot_id, :date, :status)
  end
  
  def send_allocations_csv(allocations)
    csv_data = CSV.generate do |csv|
      header = %w(id room_id timeslot_id date status created_at updated_at)
      csv << header
  
      allocations.each do |allocation|
        values = [allocation.id, allocation.room_id, allocation.timeslot_id, allocation.date, 
        allocation.status, allocation.created_at, allocation.updated_at]
        csv << values
      end
    end
    send_data(csv_data, filename: "allocations.csv")
  end
  
end
