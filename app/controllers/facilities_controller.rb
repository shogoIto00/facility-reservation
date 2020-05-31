require 'csv'

class FacilitiesController < ApplicationController
  before_action :require_user_administrator, only: [:new, :edit, :destroy]
  
  def index
    @facilities = Facility.all
    
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_facilities_csv(@facilities)
      end
    end
  end
  
  def show
    @facility = Facility.find(params[:id])
    @rooms = Room.where(facility_id: params[:id])
  end
  
  def new
    @facility = Facility.new
  end
  
  def create
    @facility = Facility.new(facility_params)

    if @facility.save
      flash[:success] = '施設を登録しました。'
      redirect_to @facility
    else
      flash.now[:danger] = '施設の登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @facility = Facility.find(params[:id])
  end
  
  def update
    @facility = Facility.find(params[:id])
    if @facility.update(facility_params)
      flash[:success] = '施設情報 は正常に更新されました'
      redirect_to @facility
    else
      flash.now[:danger] = '施設情報 は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @facility = Timeslot.find(params[:id])
    @facility.destroy

    flash[:success] = '施設 は正常に削除されました'
    redirect_to action: 'index'
  end
  
  private
  
  def facility_params
    params.require(:facility).permit(:name, :address, :access, :facility_photo)
  end
  
  def send_facilities_csv(facilities)
    csv_data = CSV.generate do |csv|
      header = %w(id name address access created_at updated_at)
      csv << header
  
      facilities.each do |facility|
        values = [facility.id, facility.name, facility.address, facility.access, facility.created_at, facility.updated_at]
        csv << values
      end
    end
    send_data(csv_data, filename: "facilities.csv")
  end
end
