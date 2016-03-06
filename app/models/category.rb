class Category < ActiveRecord::Base
  has_many :micropost_categories
  has_many :microposts, through: :micropost_categories
end
