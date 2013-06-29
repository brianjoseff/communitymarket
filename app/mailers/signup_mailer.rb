class SignupMailer < ActionMailer::Base
  default from: "no-reply@peopleandstuff.com"
  def new_subscriber(subscriber)
    @subscriber = subscriber
    mail(:to => subscriber.email, :subject => "welcome amigo/a")
  end
end
