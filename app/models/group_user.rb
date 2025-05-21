class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum role: { member: "member", admin: "admin" }
end
