require 'rails_helper'

describe Api::V1::RegistrationsController do

  let(:headers) { {HTTP_ACCEPT: 'application/json'} }

  describe 'POST /apr/v1/users/' do


    describe 'register a user' do
      it 'with valid sign up returns user & token' do
        post '/api/v1/users', {user:{user_name: 'Thomas',
                               email: 'thomas@craft.com',
                               password: 'password',
                               password_confirmation: 'password'}}, headers

        expect(response_json['message']).to eq('success')
        expect(response_json['user']['user_name']).to eq('Thomas')
        expect(response_json['user']['token']).to_not be nil
        expect(response.status).to eq 200
      end

      it 'with an invalid password confirmation returns error message' do
        post '/api/v1/users', {user:{user_name: 'Thomas',
                                     email: 'thomas@craft.com',
                                     password: 'password',
                                     password_confirmation: 'wrong_password'}}, headers
        expect(response_json['errors']['password_confirmation']).to eq(['doesn\'t match Password'])
        expect(response.status).to eq 422
      end

      it 'with an invalid email returns error message' do
        post '/api/v1/users', {user:{user_name: 'Thomas',
                                     email: 'thomas@craft',
                                     password: 'password',
                                     password_confirmation: 'password'}}, headers
        expect(response_json['errors']['email']).to eq(['is invalid'])
        expect(response.status).to eq 422
      end

      it 'with an registered email returns error message' do
        FactoryGirl.create(:user, email: 'thomas@craft.com')
        post '/api/v1/users', {user:{user_name: 'Thomas',
                                     email: 'thomas@craft.com',
                                     password: 'password',
                                     password_confirmation: 'password'}}, headers
        expect(response_json['errors']['email']).to eq(['has already been taken'])
        expect(response.status).to eq 422
      end
    end

    describe 'OmniAuth' do
      describe 'Facebook' do
        before do
          Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
          Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
          binding.pry

        end

        it 'allows user to register' do

          post '/api/v1/users/auth/facebook/callback', {}, headers
          binding.pry
        end
      end
    end

  end
end