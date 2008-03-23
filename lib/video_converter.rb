require 'base64'
require 'heywatch'

class VideoConverter

  def self.convert(iv)
    RAILS_DEFAULT_LOGGER.info "Processing a newly uploaded video"
    rv=HeyWatch::Discover.create(
      :url              => iv.url,
      :download         => true,
      :nvid             => iv.id,
      :title            => iv.title,
      :automatic_encode => true,
      :ping_url_after_transfer => DOWNLOAD_COMPLETE_URL,
      :ping_url_after_encode => ENCODED_URL,
      :format_id        => 31 # flash
    )
    RAILS_DEFAULT_LOGGER.info "Discovery returned #{rv.inspect}"
  end

  # Fetch a video from a URL for an incoming video to produce a variant.
  def self.fetch(iv, filename, url)
    RAILS_DEFAULT_LOGGER.info "Fetching a completed video."
    localfile="/tmp/#{iv.id}.flv"
    unless File.exist? localfile
      # Their HTTP crap sucks.  Nobody should have to do this.
      creds = Base64.encode64 "#{ENV['HEYWATCH_USER']}:#{ENV['HEYWATCH_PASS']}"
      system('wget', "--header=Authorization: Basic #{creds.strip}",
        "-q", "-O", localfile, url)
      raise "wget failed" unless $?.success?
    end

    RAILS_DEFAULT_LOGGER.info "Fetched the video.  Uploading to S3"

    AWS::S3::S3Object.store(
      "flv/#{iv.id}/#{filename}",
      open(localfile),
      S3_BUCKET,
      :access => :public_read,
      :content_type => 'video/x-flv'
    )

    RAILS_DEFAULT_LOGGER.info "Uploaded, updating the filename."

    iv.filename = filename
    iv.meta = HeyWatch::Video.find(iv.remote_id).attributes
    iv.save!

    RAILS_DEFAULT_LOGGER.info "...and this video is ready for action."

  end

  # Async observer repr
  def rrepr
    return "VideoConverter.new"
  end

end