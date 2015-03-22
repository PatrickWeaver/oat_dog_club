require 'spec_helper'

describe Zine do
  before do
    #blah
    @zine = Zine.new(title: "First Zine")
  end

  subject { @zine }

  it { should respond_to(:title) }
  it { should respond_to(:published) }
  it { should respond_to(:authorships) }
  it { should respond_to(:users) }
  it { should respond_to(:written_by?) }
  it { should respond_to(:add_author!) }

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

end
