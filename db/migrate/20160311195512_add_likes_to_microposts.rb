class AddLikesToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :likes, :integer, default: 0
  end
end
