require 'rails_helper'

describe MembersController, type: :controller do
  describe '#index' do
    login_user
    let(:map) { FactoryGirl.create(:map) }
    let!(:user) do
      user = User.last
      user.maps.push(map)
      user.set_role(map.id, "admin")
      user
    end

    let(:show_members) do
      get :index, params: {map_id: map.id}
    end

    it 'renders show with memberships' do
      show_members
      expect(assigns(:map)).to eq(map)
      expect(assigns(:invite)).to be_a_new(Invite)
      expect(assigns(:role)).to eq("admin")
    end

    context 'invalid user access' do
      let(:user) { User.last }
      it 'alerts the user' do
        expect(show_members).to redirect_to('/')
        expect(flash[:alert]).to eq('Unauthorized Access')
      end

      it 'redirects to home page' do
      end
    end
  end
end
