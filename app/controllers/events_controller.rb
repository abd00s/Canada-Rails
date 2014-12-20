class EventsController < ApplicationController
  def index
    @events = Event.where(user_id: current_user.id).order(:date_from)
  end

  def create
    @event = Event.new(event_params)
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
