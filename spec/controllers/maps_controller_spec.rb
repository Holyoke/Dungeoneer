require 'rails_helper'

describe MapsController, type: :controller do
  login_user
  let(:map) { FactoryGirl.create(:map) }
  let!(:user) do
    user = User.last
    user.maps.push(map)
    user.set_role(map.id, "admin")
    user
  end

  it { should use_before_action(:authenticate_user!) }

  describe '#show' do
    let(:show_map) do
      get :show, params: {id: map.id}
    end

    it 'renders show with memberships' do
      show_map
      expect(assigns(:role)).to eq("admin")
    end

    context 'when map is not found' do
      xit 'redirects to home page'
      xit 'returns notice of not found'
    end
  end

  describe '#update' do
    let(:not_owned_map) { FactoryGirl.create(:map) }
    let(:edit_maps) do
      get :edit , params: {id: not_owned_map.id}
    end

    context 'when map does not belong to user' do
      context 'unauthorized edit' do
        it 'redirects to home page' do
          expect(edit_maps).to redirect_to('/')
        end

        it 'returns proper alert' do
          edit_maps
          expect(flash[:alert]).to eq("Unauthorized access to this map")
        end
      end

      context 'when user is a collaborator of the map' do
        context 'unauthorized edit' do
          before do
            user.maps.push(not_owned_map)
          end

          it 'redirects to home page' do
            expect(edit_maps).to redirect_to('/')
          end

          it 'returns proper alert' do
            edit_maps
            expect(flash[:alert]).to eq("Unauthorized access to this map")
          end
        end
      end
    end
  end
end
