class Image < ActiveRecord::Base
  belongs_to :paragraph
  has_one :zine_content, :as => :orderable
  has_one :zine, :through => :zine_contents

  has_attached_file :image_file, :default_url => "/assets/oatpattern2.jpg"
  validates_with AttachmentContentTypeValidator, :attributes => :image_file, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :image_file, :less_than => 5.megabytes

  validates :width, numericality: {
    only_integer: true,
    greater_than: 4,
    less_than: 4001
  }
  validates :caption, length: {
    maximum: 250,
    too_long: "The maximum caption length is %{count} characters."
  }

  accepts_nested_attributes_for :zine_content
end
