S3_ID=ENV['S3_ID']

if S3_ID
  require 'aws-s3'
  S3_PW=`cat ~/.s3pw`.strip
  S3_BUCKET='nvmedia.west.spy.net'
  raise "Problem reading s3 password" unless $?.success?

  AWS::S3::Base.establish_connection!(
    :access_key_id => S3_ID,
    :secret_access_key => S3_PW
  )
end