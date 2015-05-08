require "open-uri"

class Cover < ActiveRecord::Base
  belongs_to :zine

  has_attached_file :cover_image, :default_url => "/assets/oatpattern2.jpg"
  validates_with AttachmentContentTypeValidator, :attributes => :cover_image, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :cover_image, :less_than => 5.megabytes

  def cover_from_url(url)
    self.cover_image = open(url)
  end
end
