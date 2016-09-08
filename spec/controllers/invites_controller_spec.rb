require 'rails_helper'

describe InvitesController, type: :controller do

  describe '#create' do
    login_user
    let(:project) { FactoryGirl.create(:project) }

    it 'creates a new invite' do
      post :create, params: {
        invite: {
          project_id: project.id,
          email: 'fake@email.com',
        }
      }
      expect(Invite.all.count).to eq(1)
    end

    xit 'sends email to the user' do

    end

    context 'when save is not successful' do
      xit 'does something reasonable'
    end
  end
end
