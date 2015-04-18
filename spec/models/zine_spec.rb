require 'spec_helper'

describe Zine do

  let(:user) {FactoryGirl.create(:user) }
  before { @zine = user.zines.build(title: "First Zine")}

  subject { @zine }

  it { should respond_to(:title) }
  it { should respond_to(:published) }
  it { should respond_to(:authorships) }
  it { should respond_to(:users) }
  it { should respond_to(:written_by?) }
  it { should respond_to(:add_author!) }
  it { should respond_to(:paragraphs) }
  it { should respond_to(:images) }

  it { should be_valid }
  it { should_not be_published }

  describe "when published" do
    before do
      @zine.save!
      @zine.toggle!(:published)
    end

    it { should be_published }
  end

  describe "when title is not present" do
    before { @zine.title = nil }
    it { should_not be_valid }
  end

  describe "a zine's authors" do
    let(:new_author) { FactoryGirl.create(:user) }
    before do
      @zine.save
      @zine.add_author!(new_author)
    end

    it { should be_written_by(new_author) }
    its(:users) { should include(new_author) }

    describe "and removing an author" do
      before { @zine.remove_author!(new_author) }

      it { should_not be_written_by(new_author) }
      its(:users) { should_not include(new_author) }
    end
  end

  describe "paragraph associations" do
    before { @zine.save }
    let!(:second_paragraph) do
      FactoryGirl.create(:paragraph, zine: @zine, position: 2)
    end
    let!(:first_paragraph) do
      FactoryGirl.create(:paragraph, zine: @zine, position: 1)
    end

    it "should have the paragraphs in the right order" do
      expect(@zine.paragraphs.to_a).to eq [first_paragraph, second_paragraph]
    end

    it "should destroy associated paragraphs" do
      paragraphs = @zine.paragraphs.to_a
      @zine.destroy
      expect(paragraphs).not_to be_empty
      paragraphs.each do |paragraph|
        expect(Paragraph.where(id: paragraph.id)).to be_empty
      end
    end
  end

   describe "image associations" do

    before { @zine.save }
    let!(:image1) do
      FactoryGirl.create(:image, zine: @zine)
    end
    let!(:image2) do
      FactoryGirl.create(:image, zine: @zine)
    end

    it " should destroy associated images when a zine is destroyed" do
      images = @zine.images.to_a
      @zine.destroy
      expect(images).not_to be_empty
      images.each do |image|
        expect(Image.where(id: image.id)).to be_empty
      end
    end
  end

end
