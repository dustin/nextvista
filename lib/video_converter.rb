require 'heywatch'

class VideoConverter

  def convert(iv)
    RAILS_DEFAULT_LOGGER.info "Processing a newly uploaded video"
    rv=HeyWatch::Discover.create(
      :url              => iv.url,
      :download         => true,
      :custom_fields    => { :nvid => iv.id },
      :title            => iv.title,
      :automatic_encode => true,
      :ping_url_after_transfer => DOWNLOAD_COMPLETE_URL,
      :ping_url_after_encode => ENCODED_URL,
      :format_id        => 31 # flash
    )
    RAILS_DEFAULT_LOGGER.info "Discovery returned #{rv.inspect}"
  end

end