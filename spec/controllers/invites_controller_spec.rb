require 'rails_helper'

describe InvitesController, type: :controller do
  describe '#create' do
    login_user
    let(:map) { FactoryGirl.create(:map) }
    let(:role) { "admin" }
    let(:invite_email) { 'fake@email.com' }
    let(:send_invite) do
      post :create, params: {
        invite: {
          map_id: map.id,
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
      expect(last_invite.map_id).to eq(map.id)
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
      let!(:user) { FactoryGirl.create(:user, email: invite_email) }

      it 'adds the map to the user group' do
        send_invite
        expect(user.maps).to include(map)
      end

      it 'sends email to let them know they joined the group' do
        expect(InviteMailer).to receive(:existing_user_invite).with(
          invite_email,
          map.name
        ).and_call_original
        send_invite
      end

      it 'marks invite as accepted' do
        send_invite
       expect(Invite.find_by(recipient_id: user.id).accepted).to eq(true)
      end
    end

    context 'when save is not successful' do
      xit 'redirects the user'
      xit 'notifies the user'
    end
  end
end
