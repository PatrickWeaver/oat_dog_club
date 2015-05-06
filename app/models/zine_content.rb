class ZineContent < ActiveRecord::Base
  belongs_to :zine
  belongs_to :orderable, :polymorphic => true
  acts_as_list scope: :zine

  validates :border_color, presence: true

end
