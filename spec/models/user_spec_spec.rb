require 'rails_helper'

RSpec.describe UserSpec, type: :model do
  describe 'Validations' do
    
    it 'should validate if there is an email' do
      user = User.new
      user.email = nil
      user.name = "Bob"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    
    
    it 'should validate if there is a password' do
      user = User.new
      user.name = "Bob"
      user.email = "test@test.com"
      user.password = nil
      user.password_confirmation = "password"
      user.save

      expect(user.errors.full_messages).to include("Password can't be blank")
    end    
    
    it 'should validate if there is a password_confirmation' do
      user = User.new
      user.name = "Bob"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = nil
      user.save

      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'password and password confirmation should match' do
      user = User.new
      user.name = "Bob"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      
      expect(user.save).to be true
      expect(user.password).to eq user.password_confirmation
    end
   
    it 'password and password confirmation should not match' do
      user = User.new
      user.name = "Bob"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "p"
     
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should validate a unqiue email' do
      user_one = User.new
      user_one.name = "Bob"
      user_one.email = "test@test.com"
      user_one.password = "password"
      user_one.password_confirmation = "password"
      user_one.save

      user_two = User.new
      user_two.name = "Sam"
      user_two.email = "test@test.com"
      user_two.password = "password"
      user_two.password_confirmation = "password"
      user_two.save

      expect(user_two.errors.full_messages).to include("Email has already been taken")
    end


    it 'should validate if there is a name' do
      user = User.new
      user.name = nil
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

      expect(user.errors.full_messages).to include("Name can't be blank")

    end

 

    it 'should validate the password having a minimum length' do
      user = User.new
      user.name = "Bob"
      user.email = "test@test.com"
      user.password = "pass"
      user.password_confirmation = "pass"
      user.save

      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")

    end
  end


  describe '.authenticate_with_credentials' do
    it 'should return the User with correct user and password' do
      user = User.new
      user.name = "Bill"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

      auth_user = User.authenticate_with_credentials("test@test.com", "password")
      expect(auth_user).to eq(user)
    end

    it 'should return nil with non-existant user email' do
      user = User.new
      user.name = "Bill"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

      auth_user = User.authenticate_with_credentials("testfda@test.com", "password")
      expect(auth_user).to eq(nil)
    end

    it 'should return nil with correct email, but incorrect password' do
      user = User.new
      user.name = "Bill"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

      auth_user = User.authenticate_with_credentials("test@test.com", "wrongpassword")
      expect(auth_user).to eq(nil)
    end

    it 'should return nil with incorrect password' do
      user = User.new
      user.name = "Bill"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

      auth_user = User.authenticate_with_credentials("test@test.com", "wrongpassword")
      expect(auth_user).to eq(nil)
    end

    it 'should return the User with correct user email, with added whitespace, and password' do
      user = User.new
      user.name = "Bill"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

        
      auth_user = User.authenticate_with_credentials("test  @test.com", "password")
      expect(auth_user).to eq(user)
    end


    it 'should return the User with correct user email, with uppercase letters, and password' do
      user = User.new
      user.name = "Bill"
      user.email = "test@test.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.save

        
      auth_user = User.authenticate_with_credentials("TEST@test.com", "password")
      expect(auth_user).to eq(user)
    end


  end
end
