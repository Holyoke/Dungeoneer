require 'rails_helper'

describe ProjectsController, type: :controller do
  login_user
  let(:project) { FactoryGirl.create(:project) }
  let!(:user) do
    user = User.last
    user.projects.push(project)
    user.set_role(project.id, "admin")
    user
  end

  describe '#show' do
    let(:show_project) do
      get :show, params: {id: project.id}
    end

    it 'renders show with memberships' do
      show_project
      expect(assigns(:invite)).to be_a_new(Invite)
      expect(assigns(:role)).to eq("admin")
    end

    context 'when project is not found' do
      xit 'redirects to home page'
      xit 'returns notice of not found'
    end
  end

  describe '#update' do
    let(:not_owned_project) { FactoryGirl.create(:project) }
    let(:edit_projects) do
      get :edit , params: {id: not_owned_project.id}
    end

    context 'when project does not belong to user' do
      context 'unauthorized edit' do
        it 'redirects to home page' do
          expect(edit_projects).to redirect_to('/')
        end

        it 'returns proper alert' do
          edit_projects
          expect(flash[:alert]).to eq("Unauthorized access to this project")
        end
      end

      context 'when user is a collaborator of the project' do
        context 'unauthorized edit' do
          before do
            user.projects.push(not_owned_project)
          end

          it 'redirects to home page' do
            expect(edit_projects).to redirect_to('/')
          end

          it 'returns proper alert' do
            edit_projects
            expect(flash[:alert]).to eq("Unauthorized access to this project")
          end
        end
      end
    end
  end
end
