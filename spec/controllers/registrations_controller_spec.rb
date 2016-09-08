require 'rails_helper'

describe RegistrationsController, type: :controller do
  describe '#create' do
    context 'when there is an invite token' do
      it { should use_after_action(:invite_to_project) }
    end
  end
end
