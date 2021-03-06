class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  default_scope -> { order(created_at: :desc)}
  has_many :micropost_categories
  has_many :categories, through: :micropost_categories
  accepts_nested_attributes_for :categories

  def categories_attributes=(categories_attributes)
    categories_attributes.values.each do |category_attributes|
      unless category_attributes['title'].blank?
        category = Category.find_or_create_by(category_attributes)
        self.categories << category
      end
    end
  end

  def self.top_feeds
    self.reorder('likes DESC').limit(5)
  end
end
