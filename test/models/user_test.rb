require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @test_password = 'abc123!@#'
  end

  test 'password valid with matching confirmation' do
    u = User.new({
      email: 'test@test.com',
      password: @test_password,
      password_confirmation: @test_password,
      role: 0
    })
    assert u.valid?, 'user not valid with valid password and confirmation'
  end

  test 'password confirmation must match password' do
    u = User.new({
      email: 'test@test.com',
      password: @test_password,
      password_confirmation: "#{@test_password}!",
      role: 0
    })
    assert !u.valid?, 'user valid with invalid password confirmation'
  end

  test 'password and confirmation required' do
    u = User.new({
      email: 'test@test.com',
      password: '',
      password_confirmation: @test_password,
      role: 0
    })
    assert !u.valid?, 'user valid with confirmation but no password'
  end
 
  test 'email must be present' do
    u = User.new({
      email: '',
      password: @test_password,
      password_confirmation: @test_password,
      role: 0
    })
    assert !u.valid?, 'user valid with no email'
  end

  test 'email must valid' do
    u = User.new({
      email: 'test@testcom',
      password: @test_password,
      password_confirmation: @test_password,
      role: 0
    })
    assert !u.valid?, 'user valid with invalid email'
  end
end
 