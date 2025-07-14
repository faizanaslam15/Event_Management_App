class EventMailer < ApplicationMailer
  default from: 'Noreply@carecloud.com'

  def reminder_email(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Reminder: #{@event.title} is starting soon!")
  end
end
