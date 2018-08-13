require 'rails_helper'

describe 'Full App Test' do
  it 'All Features', js: true do

    # %%% %%% %%% %%% %%% %%% %%% %%%
    # %%% %%% %%% %%% %%% %%% %%% %%%
    #
    #       INSTANCE VARIABLES
    #
    # => @user: 'angkiki' (user)
    # => @tank: 'tank' (user)
    # => @project: 'Karang Guni App'
    # => @feature: 'Feature 1'
    # => @update_feature: 'Feature 1' (after marking as completed)
    # => @bug: 'Bug 1'
    #
    # %%% %%% %%% %%% %%% %%% %%% %%%
    # %%% %%% %%% %%% %%% %%% %%% %%%


    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                starting with user registration
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    visit root_path

    click_link 'Sign Up'
    expect(page).to have_current_path(new_user_registration_path)

    fill_in 'user_username', with: 'angkiki'
    fill_in 'user_email', with: 'angkiki@test.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'

    click_button 'Sign Up', wait: 5

    expect(page).to have_current_path(dashboard_path)

    #       =============================================
    #                     data check
    #       =============================================
    @user = User.last
    expect(@user.username).to eq('angkiki')
    expect(@user.email).to eq('angkiki@test.com')

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #        log out and log in to test login user actions
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'Log Out'
    expect(page).to have_current_path(root_path)

    click_link 'Log In'
    expect(page).to have_current_path(new_user_session_path)

    fill_in 'user_email', with: 'angkiki@test.com'
    fill_in 'user_password', with: '123456'

    click_button 'Log In', wait: 5

    expect(page).to have_current_path(dashboard_path)

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                   create a new project
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'New Project'
    expect(page).to have_current_path(new_project_path)

    fill_in 'project_title', with: 'Karang Guni App'

    click_button 'Submit', wait: 5

    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content('Karang Guni App')

    #       =============================================
    #                     data check
    #       =============================================
    @project = Project.last
    expect(@project.title).to eq('Karang Guni App')
    expect(@project.users.first).to eq(@user)

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                   view project's features
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'Karang Guni App'
    expect(page).to have_current_path( project_path(@project.id) )

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                 create new project's features
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'New Feature', wait: 5
    expect(page).to have_content('New Feature')

    fill_in 'feature_name', with: 'Feature 1'
    select( 'pending', from: 'feature_status' ).select_option
    select( 'angkiki', from: 'feature_user_id' ).select_option

    click_button 'Submit', wait: 5

    expect(page).to have_content('Feature 1')

    #       =============================================
    #                     data check
    #       =============================================
    @feature = Feature.last
    expect(@feature.user).to eq(@user)
    expect(@feature.project).to eq(@project)
    expect(@feature.name).to eq('Feature 1')
    expect(@feature.status).to eq('pending')

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                 invite other users to join
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~

    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    #    create a user to be invited first
    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    @tank = User.create(email: 'tank@test.com', password: '123456', username: 'tank')

    click_link 'Invite User', wait: 5
    expect(page).to have_current_path( invite_users_path(@project.id) )

    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    #         invalid user first
    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    fill_in 'username_or_email', with: 'tanker'
    click_button 'Submit', wait: 5

    expect(page).to have_content('User Could Not Be Found')

    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    #              valid user
    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    fill_in 'username_or_email', with: 'tank'
    click_button 'Submit', wait: 5

    expect(page).to have_content("Successfully Invited User: #{@tank.username}")

    #       =============================================
    #                     data check
    #       =============================================
    expect(@tank.projects.first).to eq(@project)
    expect( ProjectUser.find_by(user_id: @tank.id, project_id: @project.id).status ).to eq('pending')

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #   log out and login with tank to accept project invitation
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'Log Out'
    expect(page).to have_current_path(root_path)

    click_link 'Log In'
    fill_in 'user_email', with: 'tank@test.com'
    fill_in 'user_password', with: '123456'

    click_button 'Log In', wait: 5

    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content('Pending Invitations')
    expect(page).to have_content('Accept Invitation')

    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    #   click on link to accept invitation
    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    click_link 'Accept Invitation'

    expect(page).to have_current_path(dashboard_path)
    expect(page).to_not have_content('Accept Invitation')

    #       =============================================
    #                     data check
    #       =============================================
    expect( ProjectUser.find_by(user_id: @tank.id, project_id: @project.id).status ).to eq('accepted')

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #               log back in with owner to see if
    #                 we can assign feature to tank
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    click_link 'Log Out'
    expect(page).to have_current_path(root_path)

    click_link 'Log In'
    fill_in 'user_email', with: 'angkiki@test.com'
    fill_in 'user_password', with: '123456'

    click_button 'Log In', wait: 5

    expect(page).to have_current_path(dashboard_path)

    click_link 'Karang Guni App'
    expect(page).to have_current_path( project_path(@project.id) )

    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    #       create new feature for tank
    # @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@ @@@
    click_link 'New Feature', wait: 5

    fill_in 'feature_name', with: 'Bug 1'
    select( 'bug', from: 'feature_status' ).select_option
    select( 'tank', from: 'feature_user_id' ).select_option

    click_button 'Submit', wait: 5

    expect(page).to have_content('Feature 1')
    expect(page).to have_content('Bug 1')
    expect(page).to have_css('.close-feature-button')

    #       =============================================
    #                     data check
    #       =============================================
    @bug = Feature.last
    expect(@bug.user).to eq(@tank)
    expect(@bug.project).to eq(@project)
    expect(@bug.name).to eq('Bug 1')
    expect(@bug.status).to eq('bugs')

    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                 mark feature as completed
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    expect(page).to have_css("#com-feat-#{@feature.id}")

    click_button "com-feat-#{@feature.id}", wait: 5
    expect(page).to_not have_css('.close-feature-button')
    #       =============================================
    #                     data check
    #       =============================================
    # @update_feature = Feature.find(@feature.id)
    # expect(@update_feature.status).to eq('completed')
  end
end
