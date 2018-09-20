require 'rails_helper'

RSpec.describe Api::AuthsController do
  subject { JSON.parse(response.body) }

  describe '#create' do
    let(:user) { create(:user) }

    context 'When password is correct' do
      before do
        post :create, :params => { email: user.email, password: user.password, remember_me: true }
      end

      it { expect(response.status).to eq 200 }
      it { expect(subject['token']).to be_present }
      it { expect(subject['user']['email']).to eq user.email }
    end

    context 'When password is incorrect' do
      before do
        post :create, :params => { email: user.email, password: 'WrongPassword', remember_me: true }
      end

      it { expect(response.status).to eq 422 }
      it { expect(subject['token']).not_to be_present }
    end
  end

  describe '#verify_token' do
    let(:user) { create(:user) }

    def contents
      {
        user_id: user.id,
        expiration: 24.hours.from_now.to_i
      }
    end

    context 'When token is correct' do
      let(:token) { JwtService.encode(contents) }

      before do
        headers = {'Authorization': "Bearer #{token}"}
        request.headers.merge! headers

        post :verify_token
      end

      it { expect(response.status).to eq 200 }
      it { expect(subject['user']['email']).to eq user.email }
    end
  end
end