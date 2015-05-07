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
  99.times do |n|
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
  width = ( @i + 1 ) * 300

  if @i > 2
    caption = Faker::Lorem.sentence
    if @n.even?
      display_caption = true
    end
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
    caption: caption,
    display_caption: display_caption,
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
    @zine_count << 0

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
    width = ( n + 1 ) * 300

    if n > 2
      caption = Faker::Lorem.sentence
      if @n.even?
        display_caption = true
      end
    end

    paragraph_id = (n + 1) * 2

    url = "app/assets/images/#{ n + 1 }.png"

    image = Image.create!(
      image_file: File.new(url),
      paragraph_id: paragraph_id,
      width: width,
      caption: caption,
      display_caption: display_caption,
      )

    image_paragraph = Paragraph.find(paragraph_id)
    zine = image_paragraph.zine_content.zine

    zine.zine_contents.create(:orderable => image, :border_color => "##{@color_lib[ ( @i % 5 ) + 5 ]}")
  end

end
