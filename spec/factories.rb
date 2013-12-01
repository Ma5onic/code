FactoryGirl.define do
	factory :user do
		sequence(:email) 		{ |n| "person-#{n}@example.com"}
		sequence(:username) { |n| "person-#{n}"}
		password "password"
		password_confirmation "password"

		factory :admin do
			admin true
		end
	end
end