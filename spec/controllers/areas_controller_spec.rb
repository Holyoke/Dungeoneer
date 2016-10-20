require 'rails_helper'

describe AreasController, type: :controller do
  login_user

  let(:map) { FactoryGirl.create(:map_with_areas) }
  let(:area) { map.areas.first}
  let!(:user) do
    user = User.last
    user.maps.push(map)
    user.set_role(map.id, "admin")
    user
  end

  describe '#show' do
    let(:show_area) do
      get :show, params: {id: map.areas.first.id}
    end

    it 'renders show page' do
      expect(show_area).to render_template('areas/show')
    end
  end

  describe '#update' do
    let(:edit_area) do
      get :edit , params: {id: area.id}
    end

    context 'when map does not belong to user' do
      before do
        user.maps = []
        user.save
      end

      context 'unauthorized edit' do
        it 'redirects to home page' do
          expect(edit_area).to redirect_to('/')
        end

        it 'returns proper alert' do
          edit_area
          expect(flash[:alert]).to eq("Unauthorized access to this map")
        end
      end

      context 'when user is a collaborator of the map' do
        context 'unauthorized edit' do
          before do
            user.maps.push(map)
            user.set_role(map.id, "collaborator")
          end

          it 'redirects to home page' do
            expect(edit_area).to redirect_to('/')
          end

          it 'returns proper alert' do
            edit_area
            expect(flash[:alert]).to eq("Unauthorized access to this map")
          end
        end
      end
    end
  end
end
