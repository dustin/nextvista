module AdminHelper

  def video_thumb(iv)
    tag("img", {:src => "http://nvmedia.west.spy.net/thumb/#{iv.id}.jpg",
      :alt => "[video #{iv.id}]"})
  end

end
