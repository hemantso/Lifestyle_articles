require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'Happy', email: 'hs@gmail.com', password: 'happy2834')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = ' '

    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '

    assert_not @user.valid?
  end

  test 'user model has secure password' do
    assert_respond_to @user, :password_digest
    assert_respond_to @user, :authenticate, 'User requires has_secure_password'
  end

  test 'username should be unique' do
    @user.save

    user2 = User.new(username: 'Happy', email: 'hs1@gmail.com', password: 'hemant2834')

    assert_not user2.valid?
  end

  test 'email should be unique' do
    @user.save

    user3 = User.new(username: 'Happy1', email: 'hs@gmail.com', password: 'hemant2834')

    assert_not user3.valid?
  end

  test 'username should not be too long' do
    @user.username = 'a' * 26

    assert_not @user.valid?
  end

  test 'username should not be too short' do
    @user.username = 'aa'

    assert_not @user.valid?
  end
end
