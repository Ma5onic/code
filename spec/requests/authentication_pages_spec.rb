require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_content('Sign In') }
		it { should have_title('Sign In') }
	end

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Sign In" }

			it { should have_title('Sign In') }
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }

			describe "after visiting another page" do
				before { click_link "Code" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Username", with: user.username.upcase
				fill_in "Password", with: user.password
				click_button "Sign In"
			end

			it { should have_title(user.name) }
			it { should have_link('My Profile',	href: custom_user_path(user)) }
			it { should have_link('Sign Out',		href: signout_path) }
			it { should_not have_link('Sign In', href: signin_path) }
		end
	end

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "when attempting to visit a protected page" do
				before do
					visit custom_edit_user_path(user)
					fill_in "Username", with: user.username
					fill_in "Password", with: user.password
					click_button "Sign In"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						expect(page).to have_title('Edit User')
					end
				end
			end

			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit custom_edit_user_path(user) }
					it { should have_title('Sign In') }
				end

				describe "submitting to the update action" do
					before { patch custom_user_path(user) }
					specify { expect(response).to redirect_to(signin_path) }
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the Users#edit action" do
				before { get custom_edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match(full_title('Edit User')) }
				specify { expect(response).to redirect_to(root_url) }
			end

			describe "submitting a PATCH request to the Users#update action" do
				before { patch custom_user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
			end
		end
	end
end
