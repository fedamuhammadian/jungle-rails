require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Validations' do
      it 'must be created with password and password_confirmation fields' do
        user = User.new(
          email: 'test@abc.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'John',
          last_name: 'Doe'
        )
        expect(user).to be_valid
      end

      it 'should have matching password and password_confirmation' do
        user = User.new(email: 'test@abc.com', password: 'password', password_confirmation: 'different_password')
        expect(user).not_to be_valid
      end

      it 'should require password and password_confirmation when creating the model' do
        user = User.new(email: 'test@abc.com')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("Password can't be blank")
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'should validate uniqueness of emails (not case-sensitive)' do
        existing_user = User.create(email: 'test@abc.com', password: 'password')
        user = User.new(email: 'TEST@ABC.COM', password: 'password')
        expect(user).not_to be_valid
      end

      it 'should require email, first name, and last name' do
        user = User.new(
          email: 'test@abc.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'John',
          last_name: 'Doe'
        )
        expect(user).to be_valid
    end

    it 'should require email, first name, and last name' do
      user = User.new(
        email: 'exam@abc.com',
        password: 'pass',
        password_confirmation: 'pass',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end


    describe '.authenticate_with_credentials' do
      before(:each) do 
        @email = "test@abc.com"
        @password = "pass"
        user = User.create(name:"Cat", email: @email, password: @password, password_confirmation: @password)
      end

      describe "test(:each)" do 
        it "If a visitor types in a few spaces before and/or after their email address they should still be authenticated successfully" do
          user = User.authenticate_with_credentials("    test@abc.com    ", @password)
          expect(user).to be_a(User)
        end
      end



    describe "test(:each)" do 
      it "should return a nil when given an invalid username" do
        user = User.authenticate_with_credentials("asd123@asd123.com", @password)
        expect(user).to eq(nil)
      end
    end

    describe "test(:each)" do 
      it "should return a nil when given an invalid password" do
        user = User.authenticate_with_credentials(@email, "123abc")
        expect(user).to eq(nil)
      end
    end


    describe "test(:each)" do 
      it "should return a nil when given an valid case-insensitive password" do
        user = User.authenticate_with_credentials("tEsT@abc.com", "PASS")
        expect(user).to eq(nil)
      end
    end
  end
end
end