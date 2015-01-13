S3FileField.config do |c|
  c.access_key_id = ENV['S3_KEY']         # your access key id
  c.secret_access_key = ENV['S3_SECRET_KEY']  # your secret access key
  c.bucket = ENV['S3_DEV_BUCKET']         # your bucket name
  # c.acl = "public-read"
  # c.expiration = 10.hours.from_now.utc.iso8601
  # c.max_file_size = 500.megabytes
  # c.conditions = []
  # c.key_starts_with = 'uploads/
end