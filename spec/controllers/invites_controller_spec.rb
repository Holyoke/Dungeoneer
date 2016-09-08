require 'rails_helper'

describe InvitesController, type: :controller do

  describe '#create' do
    login_user
    let(:project) { FactoryGirl.create(:project) }
    let(:invite_email) { 'fake@email.com' }
    let(:send_invite) do
      post :create, params: {
        invite: {
          project_id: project.id,
          email: invite_email,
        }
      }
    end

    let(:invite_link) do
      /\/users\/sign_up\?invite_token=.*/
    end

    it 'creates a new invite object' do
      send_invite
      last_invite = Invite.last
      expect(last_invite.project_id).to eq(project.id)
      expect(last_invite.email).to eq(invite_email)
      expect(last_invite.sender_id).to eq(User.last.id)
    end

    it 'sends email to the user' do
      expect(InviteMailer).to receive(:new_user_invite).with(
        invite_email,
        invite_link
      ).and_call_original
      send_invite
    end

    context 'when save is not successful' do
      xit 'does something reasonable'
    end
  end
end
