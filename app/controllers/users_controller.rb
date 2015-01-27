class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def welcome
    @user = User.new
  end  

  def show
    @now = Event.where(user: @user).order("date_from").last
    @now.date_to = Date.today
    @now.save
  end

  def new
    @user = User.new  
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      # Upon signing up, the user's first Event entry is automatically populated
      # This event starts at the user's "Landing Date" and ends Today, and has
      # the status of 1 indicating presence in Canada
      Event.create(date_from: @user.start_date, date_to: Date.today, location: "Canada", description: "Present", status: 1, user_id: @user.id)
      redirect_to user_path(@user), notice: "Signed up successfully"
    else
      render 'new', notice: "Error signing up, please try again."
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "Changes succesful"
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "Good bye!"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :application, :start_date)
  end
end