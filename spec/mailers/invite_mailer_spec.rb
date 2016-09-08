require "rails_helper"

describe InviteMailer, type: :mailer do
  describe '#new_user_invite' do
    let(:mail) { described_class.new_user_invite(email, invite_url) }
    let(:invite_url) do
      '/users/sign_up?invite_token=86f37900fc0a21e9da967b5024db091a4603cf8f'
    end
    let(:email) { 'fake@email.com' }

    it 'renders the subject' do
      expect(mail.subject).to eq('Constructive Project Invitation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['invite@constructiveapp.com'])
    end

    it 'assigns @invite_url' do
      expect(mail.body.encoded).to include("constructiveapp.com#{invite_url}")
    end
  end

  describe '#existing_user_invite' do
    let(:mail) { described_class.new_user_invite(email, project_name) }
    let(:project_name) { 'Fake project' }

    let(:email) { 'fake@email.com' }

    it 'renders the subject' do
      expect(mail.subject).to eq('Constructive Project Invitation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['invite@constructiveapp.com'])
    end

    it 'assigns @invite_url' do
      expect(mail.body.encoded).to include(
        "You have been invited to the project #{@project_name}"
      )
    end
  end
end
