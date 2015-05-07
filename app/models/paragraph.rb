class Paragraph < ActiveRecord::Base
  has_many :images
  has_one :zine_content, :as => :orderable, dependent: :destroy
  has_one :zine, :through => :zine_contents

  validates :font_size, presence: true

  accepts_nested_attributes_for :zine_content
  
end
