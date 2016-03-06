class MicropostCategory < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :category
end
