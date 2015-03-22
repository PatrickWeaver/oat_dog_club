class Zine < ActiveRecord::Base
  has_many :authorships, ->{ order 'position' }, dependent: :destroy
  has_many :users, through: :authorships

  has_many :paragraphs, dependent: :destroy

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
