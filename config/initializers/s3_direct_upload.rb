S3DirectUpload.config do |c|
  c.access_key_id = "AKIAIDQFQL6U46ZQT3AA"       # your access key id
  c.secret_access_key = "phqQmJiPBBg2Q/Ir0p4NRdQuMOv4s9beer3PRtZN"   # your secret access key
  c.bucket = "zounds-pro"              # your bucket name
  c.region = nil             # region prefix of your bucket url (optional), eg. "s3-eu-west-1"
  c.url = nil                # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end