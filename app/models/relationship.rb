class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  after_create :add_follow_activity

  private
  def add_follow_activity
    follow_activity_content = I18n.t "activity.add_follow_user", follower_user:
      follower.name, followed_user: followed.name
    Activity.create user_id: self.follower_id, activities:
      follow_activity_content
  end
end
