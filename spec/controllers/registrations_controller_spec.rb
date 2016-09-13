require 'rails_helper'

describe RegistrationsController, type: :controller do
  describe '#create' do
    context 'when there is an invite token' do
      before :each do
        request.env['devise.mapping'] = Devise.mappings[:user]
      end

      let(:email) { "fake@email.com" }
      let(:project) { FactoryGirl.create(:project) }
      let!(:invite) { Invite.create(project_id: project.id, email: email) }

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

      it { should use_after_action(:invite_to_project) }
    end
  end
end
