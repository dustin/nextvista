# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def tag_links(tags, joinwith=' ')
    tags.map {|tag| link_to tag.to_s, tag_url(:name => tag.name) }.join joinwith
  end

end
