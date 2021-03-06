class User < ActiveRecord::Base
  has_many :authorships, ->{ order 'position' }, dependent: :destroy
  has_many :zines, through: :authorships

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 100 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 4 }

  has_attached_file :profile_picture, :default_url => "https://s3.amazonaws.com/oatdogclub/oat-dog-default-small.png", styles: {
    thumb: '150x150>',
    square: '300x300#',
    medium: '500x500>',
    large: '800x800>',
    xlarge: '1200x1200>',
    full: '1600x1600>'
  }
  validates_with AttachmentContentTypeValidator, :attributes => :profile_picture, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :profile_picture, :less_than => 3.megabytes

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def authoring?(zine)
    authorships.find_by(zine_id: zine.id)
  end

  def become_author!(zine)
    authorships.create!(zine_id: zine.id)
  end

  def unbecome_author!(zine)
    authorships.find_by(zine_id: zine.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
