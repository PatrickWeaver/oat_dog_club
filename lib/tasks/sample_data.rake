namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_zines
    make_authorships
    make_paragraphs
    make_images
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

def make_zines
  30.times do |n|
    title = Faker::Lorem.words[1]
    Zine.create!(title: title,
                  published: true )
  end
end

def make_authorships
  users = User.all
  zines = Zine.all
  10.times do |n|
    user = User.find(n+1)
    zine1 = Zine.find(n+1)
    zine2 = Zine.find(n+2)
    zine3 = Zine.find(n+3)
    user.become_author!(zine1)
    user.become_author!(zine2)
    user.become_author!(zine3)
  end
end

def make_paragraphs
  color_lib = ['00FFFF', '8A2BE2', 'DC143C', 'B8860B', '228B22', 'ADFF2F', '778899', 'FFA500', 'FF4500', 'D8BFD8']
  20.times do |n|
    header = Faker::Lorem.sentence
    content = Faker::Lorem.paragraph

    m = n
    if n >= color_lib.length
      m = n-color_lib.length
    end
    border_color = color_lib[m]

    per = (n+1)/5.0
    zine_id = per.ceil
    position = (n % 5.0) + 1

    Paragraph.create!(header: header,
                      content: content,
                      border_color: border_color,
                      position: position,
                      zine_id: zine_id
                      )
  end
end

def make_images
  10.times do |n|
    url = "/assets/#{n}.png"

    per = (n+1)/5.0
    zine_id = per.ceil

    n_rem = n % 5

    cover = if n_rem == 0
      true
    else
      false
    end

    if n.even?
      paragraph_id = n
    end

    if n_rem == 0
      height = (n + 1) * 100
      width = (n + 1) * 150
    else
      height = 150 * (n_rem)
      width = 200 * (n_rem)
    end

    caption = if n.even?
      Faker::Lorem.sentence
    end

    display_caption = if n < 6
      true
    else
      false
    end



    Image.create!(  url: url,
                    zine_id: zine_id,
                    cover: cover,
                    paragraph_id: paragraph_id,
                    height: height,
                    width: width,
                    caption: caption,
                    display_caption: display_caption
                    )
  end
end
