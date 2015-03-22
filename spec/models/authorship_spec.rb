require 'spec_helper'

describe Authorship do
  let(:user) { FactoryGirl.create(:user) }
  let(:zine) { FactoryGirl.create(:zine) }
  let(:authorship) { user.authorships.build(zine_id: zine.id) }

  subject { authorship }

  it { should be_valid }

  describe "authorship methods" do
    it { should respond_to(:user) }
    it { should respond_to(:zine) }
  end

  describe "when user id is not found" do
    before { authorship.user_id = nil }
    it { should_not be_valid }
  end

  describe "when zine id is not present" do
    before { authorship.zine_id = nil }
    it { should_not be_valid }
  end
end
