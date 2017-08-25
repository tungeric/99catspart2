class Session < ApplicationRecord
  validates :user_id, :session_token, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
