require 'spec_helper'

describe Image do
  
  let!(:zine) { FactoryGirl.create(:zine) }
  let!(:paragraph_1) { FactoryGirl.create(:paragraph, zine: zine) }
  let!(:paragraph_2) { FactoryGirl.create(:paragraph, zine: zine) }
  before do
    # BLAH
    @image = Image.new(url: "/assets/3.png", zine: zine, cover: true )
    @image2 = Image.new(url: "/assets/4.png", zine: zine, paragraph: paragraph_1 )
    @image3 = Image.new(url: "/assets/5.png", zine: zine, paragraph: paragraph_2, caption: "This is a picture", display_caption: true )
  end

  subject { @image3 }

  it { should respond_to(:url) }
  it { should respond_to(:zine_id) }
  it { should respond_to(:zine) }
  its(:zine) { should eq zine }
  it { should respond_to(:cover) }
  it { should respond_to(:paragraph_id) }
  it { should respond_to(:caption) }
  it { should respond_to(:display_caption) }

  it { should be_valid }

  describe "when zine_id is not present" do
    before { @image3.zine_id = nil }
    it { should_not be_valid }
  end

  describe "when height is too big" do
    before { @image3.height = 2001 }
    it { should_not be_valid }
  end

  describe "when height is too small" do
    before { @image3.height = 4 }
    it { should_not be_valid }
  end

  describe "when width is too big" do
    before { @image3.width = 4001 }
    it { should_not be_valid }
  end

  describe "when width is too small" do
    before { @image3.width = 4 }
    it { should_not be_valid }
  end

  describe "when caption is too long" do
    before { @image3.caption = "a" * 251 }
    it { should_not be_valid }
  end

  #describe "when url is broken" do

  #end
  
end

