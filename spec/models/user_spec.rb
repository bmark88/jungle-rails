require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should not create a user if password and confirmation do not match' do
      @user = User.new({ name: 'Bob Smith', email: 'bob@testmail.com', password: '123', password_confirmation: '321'})
      expect(@user).not_to be_valid
    end

    it 'should create a new user if password and confirmation match' do
      @user = User.new({ name: 'Bob Smith', email: 'abc@gmail.com', password: '123', password_confirmation: '123'})
      expect(@user).to be_valid
    end
    
    it 'should not create a new user if email is taken' do
      @user1 = User.create({ name: 'Bob Smith', email: 'abc@gmail.com', password: '123', password_confirmation: '123'})
      @user2 = User.create({ name: 'Bob Smith', email: 'abc@gmail.com', password: '123', password_confirmation: '123'})
      expect(@user2).not_to be_valid
    end

    it 'should not create a new user if the password length is less than 3' do
      @user = User.new({ name: 'Bob Smith', email: 'abc@gmail.com', password: '12', password_confirmation: '12'})
      expect(@user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate a user based on their email and password' do
      user = User.create({ name: 'Bob Smith', email: 'abc@gmail.com', password: '123', password_confirmation: '123'})
      expect(user).to eql(User.authenticate_with_credentials('abc@gmail.com', '123'))
    end

    it 'should authenticate a user if the email has trailing spaces' do
      user = User.create({ name: 'Bob Smith', email: 'abc@gmail.com', password: '123', password_confirmation: '123'})
      expect(user).to eql(User.authenticate_with_credentials(' abc@gmail.com ', '123'))
    end

    it 'should authenticate a user based on their email regardless of case' do
      user = User.create({ name: 'Bob Smith', email: 'abc@gmail.com', password: '123', password_confirmation: '123'})
      expect(user).to eql(User.authenticate_with_credentials('aBc@GMaIL.cOm', '123'))
    end
  end
end