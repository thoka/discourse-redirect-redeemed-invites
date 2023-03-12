# frozen_string_literal: true

# name: redirect-redeemed-invites
# about: redirect directly to linked topic, if invite was redeemed earlier
# version: 0.1
# authors: Thomas Kalka (thoka)
# url: https://github.com/thoka/discourse-redirect-redeemed-invites

module RedirectRedeemedInvites
  module InvitesControllerExtension
    private
    def show_invite(invite)
      topic = invite.topics.first
      if topic.present? and invite.invited_users.exists?(user: current_user)
        redirect_to path(topic.relative_url)
      else
        super(invite)
      end
    end
  end
end

after_initialize do
  ::InvitesController.prepend RedirectRedeemedInvites::InvitesControllerExtension
end
