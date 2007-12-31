# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Generate links for a list of tag objects.
  def tag_links(tags, joinwith=' ')
    tags.map {|tag| link_to tag.to_s, tag_url(:name => tag.name) }.join joinwith
  end

  # Convert newlines to BRs
  def nl2br(s)
      s.gsub(/\n/, '<br/>')
  end

  # prep user content for display (comments, BIO, etc...)
  def user_content(s)
    nl2br escape_once(s.strip)
  end

end
