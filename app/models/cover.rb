require "open-uri"

class Cover < ActiveRecord::Base
  belongs_to :zine

  has_attached_file :cover_image, :default_url => "/assets/oatpattern2.jpg", styles: {
      thumb: '150x150>',
      square: '300x300#',
      medium: '500x500>',
      large: '800x800>',
      xlarge: '1200x1200>',
      full: '1600x1600>'
  }
  validates_with AttachmentContentTypeValidator, :attributes => :cover_image, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :cover_image, :less_than => 5.megabytes

  validates :cover_image, presence: true

  validates :width, numericality: {
    only_integer: true,
    greater_than: 4,
    less_than: 1601
  }

end
