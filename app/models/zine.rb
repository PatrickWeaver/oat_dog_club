class Zine < ActiveRecord::Base
  has_many :authorships, -> { order 'position' }, dependent: :destroy
  has_many :users, through: :authorships
  has_many :zine_contents, -> { order(position: :asc) }
  has_many :paragraphs, :through => :zine_contents, :source => :orderable, :source_type => 'Paragraph', dependent: :destroy
  has_many :images, :through => :zine_contents, :source => :orderable, :source_type => 'Image', dependent: :destroy

  validates :title, presence: true

  def written_by?(author)
    authorships.find_by(user_id: author.id)
  end

  def add_author!(author)
    authorships.create!(user_id: author.id)
  end

  def remove_author!(author)
    authorships.find_by(user_id: author.id).destroy
  end

  

end
