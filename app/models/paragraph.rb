class Paragraph < ActiveRecord::Base

  belongs_to :zine
  has_many :images

  default_scope -> { order('position') }

  validates :zine_id, presence: true
  validates :font_size, presence: true
  validates :border_color, presence: true

end
