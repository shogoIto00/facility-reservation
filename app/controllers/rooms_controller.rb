require 'csv'

class RoomsController < ApplicationController
  before_action :require_user_administrator, only: [:new, :edit, :destroy]
  def index
    @rooms = Room.all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_rooms_csv(@rooms)
      end
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @rooms = Room.where(facility_id: @room.facility_id)
    @index = @rooms.index { |n| n.id == @room.id } + 1
    
    from  = Time.current.at_beginning_of_day
    to = (from + 7.day).at_end_of_day
    @reservatioin = Reservation.all
    @re_id = []
    @reservatioin.each do |re| 
      @re_id.push(re.allocation_id)
    end
    
    @your_re_id = []
    @reservatioin.each do |re| 
      if re.user_id == current_user.id
        @your_re_id.push(re.allocation_id)
      end
    end
    
    @allocations = Allocation.where(room_id: params[:id], date: from...to).where.not(id: @re_id)
    @your_allocations = Allocation.where(room_id: params[:id], date: from...to).where(id: @your_re_id)
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)

    if @room.save
      flash[:success] = '部屋を登録しました。'
      redirect_to @room
    else
      flash.now[:danger] = '部屋の登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:success] = '部屋 は正常に更新されました'
      redirect_to @room
    else
      flash.now[:danger] = '部屋 は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    flash[:success] = '部屋 は正常に削除されました'
    redirect_to action: '/facilities'
  end
  
  private

  def room_params
    params.require(:room).permit(:name, :purpose, :price, :maximum_capacity, :facility_id)
  end
  
  def send_rooms_csv(rooms)
    csv_data = CSV.generate do |csv|
      header = %w(id facility_id name purpose price maximum_capacity created_at updated_at)
      csv << header
  
      rooms.each do |room|
        values = [room.id, room.facility_id, room.name, room.purpose, room.price, room.maximum_capacity, room.created_at, room.updated_at]
        csv << values
      end
    end
    send_data(csv_data, filename: "rooms.csv")
  end
end
