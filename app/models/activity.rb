class Activity < ActiveRecord::Base
  belongs_to :user

  def content
    if type_content == Settings.activity.RELATIONSHIP_TYPE
      I18n.t "activity.add_follow_user", user_name: user_name, target: target
    else
      I18n.t "activity.add_lesson", user_name: user_name, target: target
    end
  end

  class << self
    def from_users_followed_by user
      followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
      where "user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id
    end
  end
end
