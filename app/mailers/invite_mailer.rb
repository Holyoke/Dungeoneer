class InviteMailer < ApplicationMailer
  def new_user_invite(email, invite_url)
    domain = ENV["APP_DOMAIN"] || "constructiveapp.com"
    @invite_url = domain + invite_url

    mail(
      to: email,
      from: "invite@#{domain}",
      subject: "Constructive Project Invitation"
    )
  end
end
