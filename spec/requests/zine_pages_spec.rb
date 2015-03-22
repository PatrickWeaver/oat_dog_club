require 'spec_helper'

describe "Zine pages" do

  subject { page }

  describe "zine page" do
    let(:zine) { FactoryGirl.create(:zine) }
    let(:p1) { FactoryGirl.create(:paragraph, zine: zine, header: "One Paragraph Here", content: "This is an otter, he likes ot talk to you. What will you say to him?") }
    let(:p2) { FactoryGirl.create(:paragraph, zine: zine, header: "Two paragraph here!", content: "This is a giraffe, she is very tall. What will you reach her with?") }

    before { visit zine_path(zine) }

    it { should have_content(zine.title) }
    it { should have_title(zine.title) }

    describe "paragraphs should be present on page" do
      it { should have_content(p1.title) }
      it { should have_content(p1.content) }
      it { should have_content(p2.title) }
      it { should have_content(p2.content) }
    end
  end
end