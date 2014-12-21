class EventsController < ApplicationController
  def index
    @events = Event.where(user_id: current_user.id).order(:date_from)
  end

  def create
    @event = Event.new(event_params)
    @event.status = 2
    @event.user = current_user
    @prev = Event.where(user_id: current_user.id).order(:date_from).last
    if @event.date_from == @prev.date_from
      @prev.destroy
    else
      @prev.date_to = @event.date_from
      @prev.save
    end
    @now = Event.create(date_from: @event.date_to, date_to: Date.today, location: "Canada", description: "Present", status: 1, user_id: current_user.id)
    if @event.save
      redirect_to user_events_path, notice: "Added"
    else
      redirect_to user_events_path, notice: "Failed, try again"
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attribuyes(event_params)
      redirect_to user_events_path, notice: "Changes successfull"
    else
      redirect_to user_events_path, notice: "Failed, try again"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path, notice: "Removed event"
  end

  def event_params
    params.require(:event).permit(:date_from, :date_to, :location, :description, :status, :user_id)
  end
end
