class Article < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :tags

  validates :title, presence: true

  MAX_TAGS = 4

  def tags_attributes=(tags)
    tags.each do |_, attr|
      if (tag_name = attr[:name]).present?
        tag = Tag.find_or_create_by!(name: tag_name)
        taggings.find_or_initialize_by(tag: tag)
      end
    end
  end

  def tags_build
    (MAX_TAGS - tags.length).times do
      tags.build
    end
  end
end
