require 'spec_helper'

describe User do
  
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:authorships) }
  it { should respond_to(:zines) }
  it { should respond_to(:authoring?) }
  it { should respond_to(:become_author!) }
  it { should respond_to(:profile_picture) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 101 }
    it { should_not be_valid }
  end


  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already registered" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 3 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "authoring a zine" do
    let(:new_zine) { FactoryGirl.create(:zine) }
    before do
      @user.save
      @user.become_author!(new_zine)
    end

    describe "user relations" do
      it { should be_authoring(new_zine) }
      its(:zines) { should include(new_zine) }
    end

    describe "zine relations" do
      subject { new_zine }

      its(:users) { should include(@user) }
    end

    describe "removing" do

      subject { @user }

      describe "authorship on a zine" do
        before { @user.unbecome_author!(new_zine) }

        it { should_not be_authoring(new_zine) }
        its(:zines) { should_not include(new_zine) }
      end
    end
  end

  describe "zine associations" do

    let!(:b_zine) { FactoryGirl.create(:zine, title: "B Zine", created_at: 1.day.ago) }
    let!(:a_zine) { FactoryGirl.create(:zine, title: "A Zine", created_at: 1.hour.ago) }
    before do
      @user.save
      @user.become_author!(a_zine)
      @user.become_author!(b_zine)
    end

    it { should be_authoring(a_zine) }
    it { should be_authoring(b_zine) }
    its(:zines) { should include(a_zine) }
    its(:zines) { should include(b_zine) }
  end
end

