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
    click_link 'Karang Guni App'
    expect(current_path).to eq( project_path(@project.id) )

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                 create new project's features
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'New Feature', wait: 5
    expect(current_path).to eq( new_feature_path(proj_id: @project.id) )

    fill_in 'feature_name', with: 'Feature 1'
    select( 'pending', from: 'feature_status' ).select_option
    select( 'angkiki', from: 'feature_user_id' ).select_option

    click_button 'Submit', wait: 5

    expect(current_path).to eq( project_path(@project.id) )

    #       =============================================
    #                     data check
    #       =============================================
    @feature = Feature.last
    expect(@feature.user).to eq(@user)
    expect(@feature.project).to eq(@project)
    expect(@feature.name).to eq('Feature 1')
    expect(@feature.status).to eq('pending')

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                 invite other users to join
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~

    # create a user to be invited first
    @tank = User.create(email: 'tank@test.com', password: '123456', username: 'tank')

    click_link 'Invite User', wait: 5
    expect(current_path).to eq( invite_users_path(@project.id) )

    # invalid user first
    fill_in 'username_or_email', with: 'tanker'
    click_button 'Submit', wait: 5

    expect(page).to have_content('User Could Not Be Found')

    # valid user
    fill_in 'username_or_email', with: 'tank'
    click_button 'Submit', wait: 5

    expect(page).to have_content("Successfully Invited User: #{@tank.username}")

    #       =============================================
    #                     data check
    #       =============================================
    expect(@tank.projects.first).to eq(@project)
    expect( ProjectUser.find_by(user_id: @tank.id, project_id: @project.id).status ).to eq('pending')
  end
end
