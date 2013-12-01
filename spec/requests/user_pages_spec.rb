require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Sign Up') }
		it { should have_title(full_title('Sign Up')) }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit custom_user_path(user) }

		it { should have_content(user.username) }
		it { should have_title(full_title(user.username)) }
	end

	describe "signup" do

		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Username",			with: "username"
				fill_in "Email",				with: "user@example.com"
				fill_in "Password",		  with: "password"
				fill_in "Confirmation", with: "password"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end

	describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
    	sign_in user
    	visit custom_edit_user_path(user)
    end 

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit User") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end
end