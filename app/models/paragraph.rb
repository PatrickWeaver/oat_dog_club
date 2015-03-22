class Paragraph < ActiveRecord::Base

  belongs_to :zine

  default_scope -> { order('position') }

  validates :zine_id, presence: true
  validates :font_size, presence: true
  validates :border_color, presence: true

end
