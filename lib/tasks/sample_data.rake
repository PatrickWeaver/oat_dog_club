namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_zines
    make_authorships
    make_paragraph_images
  end
end


def make_users
  User.create!(name: "Patrick",
               email: "patrick@oatdog.club",
               password: "password",
               password_confirmation: "password",
               admin: true)
  29.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@oatdog.club"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

@zine_count = Array.new
@color_lib = ['00FFFF', '8A2BE2', 'DC143C', 'B8860B', '228B22', 'ADFF2F', '778899', 'FFA500', 'FF4500', 'D8BFD8']

def make_paragraph
  header = Faker::Lorem.sentence
  content = Faker::Lorem.paragraph

  paragraph = Paragraph.create!(
    header: header,
    content: content,
    )
  @zine.zine_contents.create(:orderable => paragraph, :position => @zine_count[@n], :border_color => "##{@color_lib[ @i % 5 ]}")
  @zine_count[@n] += 1
end

def make_image
  width_math = ( @i + 1 ) * 300

  if width_math < 1600
    width = width_math
  else
    width = 1600
  end

  if @i > 2
    caption = Faker::Lorem.sentence
  end

  url = 
  if @i.odd?
    "app/assets/images/#{ ( @i % 5 ) + 1 }.png"
  else
    "app/assets/images/#{ ( ( @i % 5 ) * 2 ) + 1 }.png"
  end

  image = Image.create!(
    image_file: File.new(url),
    width: width,
    caption: caption
    )
  @zine.zine_contents.create(:orderable => image, :position => @zine_count[@n], :border_color => "##{@color_lib[ ( @i % 5 ) + 5 ]}")
  @zine_count[@n] += 1
end

def make_zines
  5.times do |n|
    @n = n
    title = Faker::Lorem.words[1]
    @zine = Zine.create!(
      title: title,
      published: true )
    @zine_count << 1

    5.times do |i|
      @i = i
      if i.odd?
        make_paragraph
        make_image
      else
        make_image
        make_paragraph
      end
    end

    cover_width_math = (@i + 1) * 300

    if cover_width_math < 1600
      cover_width = cover_width_math
    else
      cover width = 1600
    end

    @zine.create_cover!(:width => cover_width, border_color: "#000000", cover_image: File.new("app/assets/images/#{ @i + 1 }.png" ) )

  end
end

def make_authorships
  users = User.all
  zines = Zine.all
  2.times do |n|
    user = User.find(n+1)
    zine1 = Zine.find(n+1)
    zine2 = Zine.find(n+2)
    zine3 = Zine.find(n+3)
    user.become_author!(zine1)
    user.become_author!(zine2)
    user.become_author!(zine3)
  end
end

def make_paragraph_images
  10.times do |n|
    width_math = ( n + 1 ) * 300

  if width_math < 1600
    width = width_math
  else
    width = 1600
  end

    if n > 2
      caption = Faker::Lorem.sentence
    end

    paragraph_id = (n + 1) * 2

    url = "app/assets/images/#{ n + 1 }.png"

    image = Image.create!(
      image_file: File.new(url),
      paragraph_id: paragraph_id,
      width: width,
      caption: caption
      )

  end

end