class PostScore < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
