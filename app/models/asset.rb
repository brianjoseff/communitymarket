class Asset < ActiveRecord::Base
  # Assets are the polymorphic object that holds multiple
  # images for Posts, Users, Groups, etc..
  
  attr_accessible :imageable_id, :image
  #settings for Paperclip gem that attaches images
  has_attached_file :image, :styles => { :normal => "100%",:small => "100 x100>",:medium => "200x200>", :thumb => "50x50>", :mini => "25x25>" },
                            :storage => :s3,
                            :s3_credentials => Proc.new{|a| Rails.env.production? ? a.instance.prod_s3_credentials :  a.instance.s3_credentials}, 
                            # :s3_credentials => "#{Rails.root}/config/s3.yml", 
                            :path => "/:attachment/:id/:style/:filename"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]                          
  def to_jq_upload
    {
      "name" => read_attribute(:package_file_name),
      "size" => read_attribute(:package_file_size),
      "url" => package.url(:original),
      "delete_url" => submission_path(self),
      "delete_type" => "DELETE"
    }
  end

  def prod_s3_credentials
     {:bucket => "ambition-prod", :access_key_id => ENV['S3_SECRET'], :secret_access_key => ENV['S3_SECRET_KEY']}
  end
  def s3_credentials
      {:bucket => "ambition-dev", :access_key_id => ENV['S3_SECRET'], :secret_access_key => ENV['S3_SECRET_KEY']}
  end

end
