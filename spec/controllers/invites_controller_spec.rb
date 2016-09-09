require 'rails_helper'

describe InvitesController, type: :controller do
  describe '#create' do
    login_user
    let(:project) { FactoryGirl.create(:project) }
    let(:role) { "admin" }
    let(:invite_email) { 'fake@email.com' }
    let(:send_invite) do
      post :create, params: {
        invite: {
          project_id: project.id,
          email: invite_email,
          role: "admin"
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
      expect(last_invite.role).to eq("admin")
    end

    context 'when user email does not exist' do
      it 'sends email to the user' do
        expect(InviteMailer).to receive(:new_user_invite).with(
          invite_email,
          invite_link
        ).and_call_original
        send_invite
      end
    end

    context 'when user email does exist' do
      let(:invite_email) { 'existing@email.com' }

      it 'adds the project to the user group' do
        user = FactoryGirl.create(:user, email: invite_email)
        send_invite
        expect(user.projects).to include(project)
      end

      it 'sends email to let them know they joined the group' do
        FactoryGirl.create(:user, email: invite_email)
        expect(InviteMailer).to receive(:existing_user_invite).with(
          invite_email,
          project.name
        ).and_call_original
        send_invite
      end
    end

    context 'when save is not successful' do
      xit 'redirects the user'
      xit 'notifies the user'
    end
  end
end
