require 'rails_helper'

describe MembersController, type: :controller do
  describe '#index' do
    login_user
    let(:project) { FactoryGirl.create(:project) }
    let!(:user) do
      user = User.last
      user.projects.push(project)
      user.set_role(project.id, "admin")
      user
    end

    let(:show_members) do
      get :index, params: {project_id: project.id}
    end

    it 'renders show with memberships' do
      show_members
      expect(assigns(:project)).to eq(project)
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
