class School < ActiveRecord::Base
  attr_accessible :location, :name, :id, :school_id, :image

  # accepts_nested_attributes_for :user

  has_attached_file :image, :styles => { :normal => "100%",:small => "100 x100>",:medium => "200x200>", :thumb => "50x50>", :mini => "25x25>" },
                            :storage => :s3,
                            :path => "/:attachment/:id/:style/:filename",
                            :s3_credentials => Proc.new{|a| Rails.env.production? ? a.instance.prod_s3_credentials :  a.instance.s3_credentials}
                            


  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  def prod_s3_credentials
     {:bucket => "zounds-prod", :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}
  end
  def s3_credentials
      {:bucket => "zounds-dev", :access_key_id => "AKIAJQRMRJJSRUFI2PKQ", :secret_access_key => "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"}
  end
  
end
