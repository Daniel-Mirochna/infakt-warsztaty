require 'rails_helper'

describe 'Log in', type: :feature do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
		user
  end

  context 'when user is not registered' do
    let(:email) { 'not_existing@email.com' }
    let(:password) { 'password' }

    it 'displays error message' do # wszystkie capybarowe akcje wykonujemy w bloku it
      within '#new_user' do
        fill_in 'user_email',	with: email
        fill_in 'user_password',	with: password
        click_button 'Log in'
      end

      expect(page).to have_content('Invalid Email or password.')
    end
  end

  context 'when user is registered' do
		let(:email) { user.email }
    let(:password) { user.password }

    it 'logs in' do
			within '#new_user' do
				fill_in 'user_email',	with: email
				fill_in 'user_password',	with: password
				click_button 'Log in'
			end

    	expect(page).to have_content('Signed in successfully.')
    end
	end

	context 'when user is registered 2' do
		let(:user) { create(:user, email: email, password: password, password_confirmation: password) }
		let(:email) { "capybara@test.pl" }
    let(:password) { "123123" }

    it 'logs in' do
			within '#new_user' do
				fill_in 'user_email',	with: email
				fill_in 'user_password', with: password
				click_button 'Log in'
			end

    	expect(page).to have_content('Signed in successfully.')
    end
	end
end