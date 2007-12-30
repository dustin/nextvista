class Tag < ActiveRecord::Base

  validates_uniqueness_of :name, :case_sensitive => false

  def to_s
    if display_name.nil?
      name
    else
      display_name
    end
  end

end
