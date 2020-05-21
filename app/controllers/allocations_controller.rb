class AllocationsController < ApplicationController
  def index
    @allocation = Allocation.all
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
      flash[:success] = '時間枠 は正常に更新されました'
      redirect_to  @allocation
    else
      flash.now[:danger] = '時間枠 は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @allocation = Allocation.find(params[:id])
    @allocation.destroy

    flash[:success] = '時間枠 は正常に削除されました'
    redirect_to action: '/room/' + @allocation.room_id.to_s
  end
  
  private

  def allocation_params
    params.require(:allocation).permit(:room_id, :timeslot_id, :date, :status)
  end
end
