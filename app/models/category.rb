class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }#Specifies minimum & maxium category name length.
  validates_uniqueness_of :name#Ensures that :name is unique.
end