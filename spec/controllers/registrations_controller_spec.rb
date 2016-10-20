require 'rails_helper'

describe RegistrationsController, type: :controller do
  describe '#create' do
    context 'when there is an invite token' do
      before :each do
        request.env['devise.mapping'] = Devise.mappings[:user]
      end

      let(:email) { "fake@email.com" }
      let(:map) { FactoryGirl.create(:map) }
      let!(:invite) { Invite.create(map_id: map.id, email: email) }

      let(:register_user) do
        post :create, params: {
          invite_token: invite.token,
          user: {
            email: email,
            password: "supersecret",
          }
        }
      end

      it 'accepts invitation' do
        expect(invite.accepted).to eq(false)
        register_user
        invite.reload
        expect(invite.accepted).to eq(true)
      end

      it { should use_after_action(:invite_to_map) }
    end
  end
end
