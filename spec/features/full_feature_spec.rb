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

    #       =============================================
    #                     data check
    #       =============================================
    @user = User.last
    expect(@user.username).to eq('angkiki')
    expect(@user.email).to eq('angkiki@test.com')

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

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                   create a new project
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'New Project'
    expect(current_path).to eq(new_project_path)

    fill_in 'project_title', with: 'Karang Guni App'

    click_button 'Submit', wait: 5

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Karang Guni App')

    #       =============================================
    #                     data check
    #       =============================================
    @project = Project.last
    expect(@project.title).to eq('Karang Guni App')
    expect(@project.find_owner).to eq(@user)
    expect(@project.users.first).to eq(@user)

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                   view project's features
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  end
end
