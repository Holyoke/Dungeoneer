require 'rails_helper'

describe AreasController, type: :controller do
  login_user

  let(:project) { FactoryGirl.create(:project_with_areas) }
  let(:area) { project.areas.first}
  let!(:user) do
    user = User.last
    user.projects.push(project)
    user.set_role(project.id, "admin")
    user
  end

  describe '#show' do
    let(:show_area) do
      get :show, params: {id: project.areas.first.id}
    end

    it 'renders show page' do
      expect(show_area).to render_template('areas/show')
    end
  end

  describe '#update' do
    let(:edit_area) do
      get :edit , params: {id: area.id}
    end

    context 'when project does not belong to user' do
      before do
        user.projects = []
        user.save
      end

      context 'unauthorized edit' do
        it 'redirects to home page' do
          expect(edit_area).to redirect_to('/')
        end

        it 'returns proper alert' do
          edit_area
          expect(flash[:alert]).to eq("Unauthorized access to this project")
        end
      end

      context 'when user is a collaborator of the project' do
        context 'unauthorized edit' do
          before do
            user.projects.push(project)
            user.set_role(project.id, "collaborator")
          end

          it 'redirects to home page' do
            expect(edit_area).to redirect_to('/')
          end

          it 'returns proper alert' do
            edit_area
            expect(flash[:alert]).to eq("Unauthorized access to this project")
          end
        end
      end
    end
  end
end
