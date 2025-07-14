module Api
  module V1
    class EventsController < ApplicationController
      before_action :authorize_request
      before_action :set_event, only: [:show, :update, :destroy]

      def index
        events = Event.all
        render json: events
      end

      def show
        render json: @event
      end

      def create
        event = current_user.events.create(event_params)
        if event.persisted?
          render json: event, status: :created
        else
          render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @event.destroy
        head :no_content
      end

      def upcoming
        events = Event.where("date >= ?", Time.now)
        render json: events
      end

      def past
        events = Event.where("date < ?", Time.now)
        render json: events
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      def event_params
        params.require(:event).permit(:title, :description, :date)
      end
    end
  end
end
