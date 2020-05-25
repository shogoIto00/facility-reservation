class ReservationsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :destroy]
  before_action :require_user_administrator, only: [:edit]
  
  def index
    if @current_user.administrator
      @reservations = Reservation.all
    else
      from  = Time.current.at_beginning_of_day
      #@reservations = Reservation.where(user_id: @current_user.id)
      @reservations = Reservation.where(user_id: @current_user.id);
      
      @future_reservation = []
      @past_reservation = []
      @reservations.each_with_index do |reservation,i|
        if reservation.allocation.date <= from  
          @past_reservation.push(reservation) ;
        else
          @future_reservation.push(reservation) ;
        end
      end
    end
  end
  
  def show
      @reservation = Reservation.find(params[:id])
  end
  
  def new
    @reservation = Reservation.new
    @user = User.find_by(id: session[:user_id])
    @allocation = Allocation.find(params[:allocation_id]);
    
    @judge = Reservation.where(allocation_id: @allocation.id).exists?;
  end
  
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      flash[:success] = '下記内容で予約を行いました。ご登録ありがとうございました。'
      redirect_to @reservation
    else
      flash.now[:danger] = '予約は正常に登録されませんでした。'
      render :new
    end
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
    @user = User.find_by(id: session[:user_id])
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:success] = '予約状況 は正常に更新されました'
      redirect_to @reservation
    else
      flash.now[:danger] = '予約状況 は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    flash[:success] = '予約 は正常にキャンセルされました'
    redirect_to '/reservations'
  end
  
  private

  def reservation_params
    params.require(:reservation).permit(:allocation_id, :user_id, :status)
  end
end
