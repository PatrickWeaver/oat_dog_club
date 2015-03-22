require 'spec_helper'

describe Paragraph do
  let(:zine) { FactoryGirl.create(:zine) }
  before { @paragraph = zine.paragraphs.build(header: "Number 1 Zine", content: "This is my first paragraph. You are reading it now. Have fun!") }

  subject { @paragraph }

  it { should respond_to(:header) }
  it { should respond_to(:content) }
  it { should respond_to(:border_color) }
  it { should respond_to(:font_size) }
  it { should respond_to(:position) }
  it { should respond_to(:zine_id) }
  it { should respond_to(:zine) }
  its(:zine) { should eq zine }

  it { should be_valid }

  describe "when zine_id is not present" do
    before { @paragraph.zine_id = nil }
    it { should_not be_valid }
  end

  describe "when border_color is not present" do
    before { @paragraph.border_color = nil }
    it { should_not be_valid }
  end

  describe "when font_size is not present" do
    before { @paragraph.font_size = nil }
    it { should_not be_valid }
  end
end
