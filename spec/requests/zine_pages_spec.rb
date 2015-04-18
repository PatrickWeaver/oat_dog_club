require 'spec_helper'

describe "Zine pages" do

  subject { page }

  describe "zine page" do
    let!(:zine) { FactoryGirl.create(:zine) }
    let!(:zine2) { FactoryGirl.create(:zine) }
    let!(:author) { FactoryGirl.create(:user) }
    let!(:not_author) { FactoryGirl.create(:user)}
    let!(:p1) { FactoryGirl.create(:paragraph, zine: zine) }
    let!(:p2) { FactoryGirl.create(:paragraph, zine: zine) }
    let!(:p3) { FactoryGirl.create(:paragraph, zine: zine2) }
    let!(:image1) { FactoryGirl.create(:image, zine: zine, cover: true, paragraph: p1, height: 200, width: 200, caption: "Image One", display_caption: true) }
    let!(:image2) { FactoryGirl.create(:image, zine: zine, paragraph: p2, height: 200, width: 200, caption: "This caption is display false", display_caption: false) }
    let!(:image3) { FactoryGirl.create(:image, zine: zine2, paragraph: p3, caption: "This caption is in another zine", display_caption: true) }
    let!(:image4) { FactoryGirl.create(:image, zine: zine, display_caption: true) }
    let!(:image5) { FactoryGirl.create(:image, zine: zine, paragraph: p3 ) }



    before do
      author.become_author!(zine)
      visit zine_path(zine)
    end

    it { should have_content(zine.title) }
    it { should have_title(zine.title) }
    it { should_not have_content(zine2.title) }

    describe "paragraphs should be present on page" do
      it { should have_content(p1.header) }
      it { should have_content(p1.content) }
      it { should have_content(p2.header) }
      it { should have_content(p2.content) }
    end

    describe "images and captions should be present on page" do
      describe "for images in paragraphs" do
        it { should have_css("img[src*='#{image1.url}']") }
        it { should have_css("img[src*='#{image2.url}']") }
      end

      describe "for images not in paragraphs" do
        it { should have_css("img[src*='#{image4.url}']") }
      end

      describe "for captions with display true" do
        it { should have_content(image1.caption) }
      end
    end

    describe "images and captions should not be present on page" do

      describe "for captions with display false" do
        it { should_not have_content(image2.caption) }
      end

      describe "for images in different zines" do
        it { should_not have_css("img[src*='#{image3.url}']") }
        it { should_not have_content(image3.caption) }
      end

      describe "for images in zine but in a paragraph not in the zine" do
        it { should_not have_css("img[src*='#{image5.url}']") }
        it { should_not have_content(image5.caption) }
      end
    end

    describe "when a zine is not published" do

      before do
        zine.published = false
        zine.save
        visit zine_path(zine)
      end



      describe "for non-signed in" do
        it { should_not have_content(zine.title) }
        it { should have_content("Welcome to Oat Dog Club!")}
      end

      describe "non author" do
        before do
          sign_in not_author
          visit zine_path(zine)
        end

        it { should_not have_content(zine.title) }
        it { should have_content("Welcome to Oat Dog Club!")}

        describe "admin" do
          subject { not_author }
          it { should_not be_admin }

          describe "admin" do
            before do  
              not_author.save!
              not_author.toggle!(:admin)
            end

            it { should be_admin }

            describe "looking at zine page" do

              subject { page }
              before do
                visit zine_path(zine)
              end

              it { should have_content(zine.title) }
              it { should_not have_content("Welcome to Oat Dog Club!")}
            end
          end
        end
      end

      describe "for an author" do
        before do
          sign_in author
          visit zine_path(zine)
        end

        it { should have_content(zine.title) }
        it { should_not have_content("Welcome to Oat Dog Club!")}
      end

    end

  end
end