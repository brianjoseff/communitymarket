class SignupMailer < ActionMailer::Base
  default from: "from@example.com"
  def new_subscriber(subscriber)
    @subscriber = subscriber
    mail(:to => subscriber.email, :subject => "welcome to ")
  end
end
