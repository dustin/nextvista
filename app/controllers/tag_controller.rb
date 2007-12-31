class TagController < ApplicationController

  def index
    subtitle 'Tag Cloud'
    @tags=Video.tag_counts
  end

  def show
    tagnames=params[:name].split(/\s/).sort.uniq
    subtitle "Videos Tagged #{tagnames.join '+'}"
    @tags=Tag.find :all, :conditions => {:name => tagnames}
    @videos=Video.find_tagged_with(tagnames.join(' '), :match_all => true)
    related=Set.new

    @videos.each do |video|
      related.merge video.tag_list
    end
    @related=Tag.find :all, :conditions => {:name => related.reject {|t| tagnames.include? t}}
    @tagnames=tagnames
  end

end
