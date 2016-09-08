class InviteMailer < ApplicationMailer
  def new_user_invite(invite, invite_url)
    @invite = invite
    domain = ENV["APP_DOMAIN"]
    @invite_url = domain + invite_url
    mg_client = Mailgun::Client.new(ENV["MAILGUN_API_KEY"])

    html_output = render_to_string(template: "invite_mailer/new_user_invite.html.erb")

    message_params = {
      from: "invite@#{domain}",
      to: invite.email,
      subject: "Constructive Project Invitation",
      html: html_output.to_str
    }
    mg_client.send_message(domain, message_params).to_h!
  end
end
