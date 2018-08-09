require 'rails_helper'

describe 'Full App Test' do
  it 'All Features', js: true do
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    #                starting with user registration 
    # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
    visit root_path

    click_link 'Sign Up'
    expect(current_path).to eq(new_user_registration_path)
  end
end
