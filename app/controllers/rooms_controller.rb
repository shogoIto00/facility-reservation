class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    from  = Time.current.at_beginning_of_day
    to = (from + 7.day).at_end_of_day
    @allocations = Allocation.where(room_id: params[:id], date: from...to )
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
end
