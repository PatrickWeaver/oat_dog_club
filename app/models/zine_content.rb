class ZineContent < ActiveRecord::Base
  belongs_to :zine
  belongs_to :orderable, :polymorphic => true

  validates :border_color, presence: true

end
