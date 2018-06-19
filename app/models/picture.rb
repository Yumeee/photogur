class Picture < ActiveRecord::Base
  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.pictures_created_in_year(year)
    beginning = Date.new(year,1,1)
    end_year = Date.new(year,12,31)
    Picture.where("created_at > ?", beginning).where("created_at < ?", end_year)
  end
end
