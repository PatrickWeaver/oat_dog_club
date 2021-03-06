require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "index" do
    
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_title('Members') }
    it { should have_content('All members') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
    
    describe "delete links" do

      it { should_not have_link('delete') }


      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Join the club!" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",      with: "password"
        fill_in "Password again",  with: "password"
      end

      it " should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end      
    end
  end


  describe "profile page" do

    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(full_title(user.name)) }

    describe "zines" do
      let!(:zine) { FactoryGirl.create(:zine) }
      before do
        zine.add_author!(user)
      end

      describe "zine" do
        subject { zine }
        it { should be_written_by(user) }
      end

      describe "user page" do
        before { visit user_path(user) }
        subject { page }
        it { should have_content(zine.title) }

        describe "delete and publish/unpublish links" do
          it { should_not have_link('delete') }
          it { should_not have_link('publish') }
          it { should_not have_link('unpublish') }
        end

        describe "as an admin user" do
          let(:admin) { FactoryGirl.create(:admin) }
          before do
            sign_in admin
            visit user_path(user)
          end

          it { should have_link('unpublish' )}

          it { should have_link('delete', href: zine_path(zine)) }
          it "should be able to delete the zine" do
            expect do
              click_link('delete', match: :first)
            end.to change(Zine, :count).by(-1)
          end
        end
 
        describe "as current user" do
          let!(:zine2) { FactoryGirl.create(:zine) }
          before do
            zine2.add_author!(user)
          end
          before do
            sign_in user
            visit user_path(user)
          end

          it { should have_link('delete', href: zine_path(zine2)) }
          it "should be able to delete the zine" do
            expect do
              click_link('delete', match: :first)
            end.to change(Zine, :count).by(-1)
          end
        end
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_link("Sign out", href: signout_path) }
      it { should_not have_link("Sign in", href: signin_path) }
      it { should have_content("Update your membership") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_selector('div.alert-danger') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Your name here:",             with: new_name
        fill_in "Your electronic mail address:",            with: new_email
        fill_in "Password, shh! Secret!:",         with: user.password
        fill_in "Password one more time, I know, just do it:", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link("Sign out", href: signout_path) }
      it { should_not have_link("Sign in", href: signin_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
