class InviteMailer < ApplicationMailer
  DOMAIN =  ENV["APP_DOMAIN"] || "dungeoneer.com"

  def new_user_invite(email, invite_url)
    @invite_url = DOMAIN + invite_url

    mail(
      to: email,
      from: "invite@#{DOMAIN}",
      subject: "Dungeoneer Map Invitation"
    )
  end

  def existing_user_invite(email, map_name)
    @map_name = map_name
    mail(
      to: email,
      from: "invite@#{DOMAIN}",
      subject: "Dungeoneer Invitation"
    )
  end
end
