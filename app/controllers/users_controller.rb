class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @now = @user.events.last(order: "date_from").date_to = Date.now
    @now.save
  end

  def new
    @user = User.new  
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      Event.create(date_form: @user.start_date, date_to: Date.now, location: "Canada", description: "Present", status: 1, user_id: @user.id)
      redirect_to user_path(@user), notice: "Signed up successfully"
    else
      render 'new', notice: "Error signing up, please try again."
    end
  end

  def edit
  end

  def update
    if @user.uppdate_attributes(user_params)
      redirect_to user_path(@user), notice: "Changes succesful"
    else
      redner 'edit'
    end
  end

  def destroy
    @user.destroy, notice: "Good bye!"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :application, :start_date)
end
