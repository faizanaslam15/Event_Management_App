module Api
  module V1
    class RsvpsController < ApplicationController
      before_action :authorize_request

      def create
        event = Event.find(params[:event_id])
        if event.attendees.include?(current_user)
          render json: { message: "Already RSVPed" }, status: :ok
        else
          event.attendees << current_user
          render json: { message: "RSVP successful" }, status: :created
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Event not found" }, status: :not_found
      end
    end
  end
end
