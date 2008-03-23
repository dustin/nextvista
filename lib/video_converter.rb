require 'heywatch'
require 'net/http'

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
    File.open "/tmp/#{filename}", 'wb' do |f|
      Net::HTTP.get URI.parse(url) do |chunk|
        f.write chunk
      end
    end
    RAILS_DEFAULT_LOGGER.info "Fetched the video.  Must do something!"
  end

  # Async observer repr
  def rrepr
    return "VideoConverter.new"
  end

end