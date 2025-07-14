namespace :events do
  desc "Send email reminders 1 hour before event"
  task send_reminders: :environment do
    now = Time.current
    upcoming_events = Event.where(date: (now + 59.minutes)..(now + 61.minutes))
    
    upcoming_events.each do |event|
      event.attendees.each do |user|
        EventMailer.reminder_email(user, event).deliver_now
        puts "Reminder sent to #{user.email} for event: #{event.title}"
      end
    end
  end
end
