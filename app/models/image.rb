class Image < ActiveRecord::Base
  belongs_to :zine
  belongs_to :paragraph
  validates :zine_id, presence: true

  validates :height, numericality: { only_integer: true, greater_than: 4, less_than: 2001, allow_nil: true }
  validates :width, numericality: {
    only_integer: true,
    greater_than: 4,
    less_than: 4001
  }
  validates :caption, length: {
    maximum: 250,
    too_long: "The maximum caption length is %{count} characters."
  }
end
