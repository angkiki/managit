require 'rails_helper'

describe 'Full App Test' do
  it 'All Features', js: true do
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                starting with user registration
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    visit root_path

    click_link 'Sign Up'
    expect(current_path).to eq(new_user_registration_path)

    fill_in 'user_username', with: 'angkiki'
    fill_in 'user_email', with: 'angkiki@test.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'

    click_button 'Sign Up', wait: 5

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Hi: angkiki!')

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #        log out and log in to test rest of user actions
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'Log Out'
    expect(current_path).to eq(root_path)

    click_link 'Log In'
    expect(current_path).to eq(new_user_session_path)

    fill_in 'user_email', with: 'angkiki@test.com'
    fill_in 'user_password', with: '123456'

    click_button 'Log In', wait: 5

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Hi: angkiki!')
  end
end
