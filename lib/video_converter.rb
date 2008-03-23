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
      download url, localfile, true
    end

    RAILS_DEFAULT_LOGGER.info "Fetched the video.  Uploading to S3"

    AWS::S3::S3Object.store(
      "flv/#{iv.id}/#{filename}",
      open(localfile),
      S3_BUCKET,
      :access => :public_read,
      :content_type => 'video/x-flv'
    )
    # We don't need you, anymore
    File::unlink localfile

    RAILS_DEFAULT_LOGGER.info "Uploaded, grabbing the thumbnail."
    hv = HeyWatch::Video.find(iv.remote_id)

    thumbfile = "/tmp/thumb.#{iv.id}.jpg"
    download hv.specs.thumb, thumbfile
    AWS::S3::S3Object.store(
      "thumb/#{iv.id}.jpg",
      open(thumbfile),
      S3_BUCKET,
      :access => :public_read,
      :content_type => 'image/jpg'
    )
    File::unlink thumbfile

    RAILS_DEFAULT_LOGGER.info "Thumbnail captured, we're almost home."

    iv.filename = filename
    iv.meta = hv.attributes
    iv.state = IncomingVideo::STATE_COMPLETE
    iv.save!

    RAILS_DEFAULT_LOGGER.info "...and this video is ready for action."

  end

  # Async observer repr
  def rrepr
    return "VideoConverter.new"
  end

  private

  def self.download(url, localfile, auth=false)
    args=['wget']
    if auth
      # Their HTTP crap sucks.  Nobody should have to do this.
      creds = Base64.encode64 "#{ENV['HEYWATCH_USER']}:#{ENV['HEYWATCH_PASS']}"
      args << "--header=Authorization: Basic #{creds.strip}"
    end
    args += ["-q", "-O", localfile, url]
    system(*args)
    raise "wget failed" unless $?.success?
  end

end