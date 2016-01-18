class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  after_create :add_follow_activity

  private
  def add_follow_activity
    Activity.create user_id: follower.id, user_name: follower.name,
      target: followed.name, type_content: Settings.activity.
      RELATIONSHIP_TYPE
  end
end
