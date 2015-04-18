AWS.config(
  access_key_id:        ENV['AWSAccessKeyId'],
  secret_access_key:    ENV['AWSSecretKey'] 
  )

S3_BUCKET = AWS::S3.new.buckets[ENV['s3BUCKET']]