require 'rails_helper'

RSpec.describe 'User login page' do
  it 'has fields to input a username and password' do
    visit login_path

    expect(page).to have_field('Email:')
    expect(page).to have_field('Password:')
    expect(page).to have_button('Log In')
  end

  it 'takes user to dashboard if login info is correct' do
    user = User.create!(name: 'Christian', email: 'christian@gmail.com', password: 'password')

    visit login_path

    fill_in 'Email:', with: user.email
    fill_in 'Password:', with: user.password
    click_button('Log In')

    save_and_open_page
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, #{user.email}")
  end

  it 'doesnt accept login if email does not exist' do
    visit login_path

    fill_in 'Email:', with: 'test@email.com'
    fill_in 'Password:', with: 'password'
    click_button('Log In')

    expect(page).to have_content('Invalid login')
  end

  it 'does not log in with incorrect password' do
    user = User.create!(name: 'Christian', email: 'christian@gmail.com', password: 'password')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: 'incorrect password'
    click_button('Log In')

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Invalid login')
  end

  it 'does not log in with incorrect email' do
    user = User.create!(name: 'Christian', email: 'christian@gmail.com', password: 'password')

    visit login_path

    fill_in :email, with: 'incorrect email'
    fill_in :password, with: user.password
    click_button('Log In')

    save_and_open_page
    expect(current_path).to eq(login_path)
    expect(page).to have_content('Invalid login')
  end
end