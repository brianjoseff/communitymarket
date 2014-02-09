class PurchaseCompletedMailer < ActionMailer::Base
  default from: "thankyou@peopleandstuff.com"
  def notify(buyer, post, seller)
    @seller = seller
    @buyer = buyer
    @post = post
    # @category = category
    @post_name = post.title
    @post_desc  = post.description
    #attachments[""]
    attachments["morano.png"] = File.read("#{Rails.root}/app/assets/images/morano.png")
    #mail(:to => @seller.email,:bcc => [ENV["GMAIL_USERNAME"], ENV["MORANO_EMAIL"]], :subject => "[Sold] #{@post_name}", :reply_to => @buyer.email)
    mail(:to => @buyer.email,:bcc => [ENV["GMAIL_USERNAME"]], :subject => "You bought | #{@post_name}", :reply_to => @seller.email)
  end
end
