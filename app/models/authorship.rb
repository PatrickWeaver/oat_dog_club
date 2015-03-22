class Authorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :zine
  validates :user_id, presence: true
  validates :zine_id, presence: true
  acts_as_list scope: :user
end
