class Article < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :tags

  has_many :searched_tags, ->(tags) { where(name: tags) }, through: :taggings, class_name: 'Tag'

  validates :title, presence: true

  MAX_TAGS = 4

  def tags_attributes=(tags)
    tentative_tags = []

    tags.each do |_, attr|
      if (tag_name = attr[:name]).present?
        tag = Tag.find_or_create_by!(name: tag_name)
        tentative_tags << tag
      end
    end

    # through: :taggingsしているので中間テーブルのtagginsも自動で作成される
    self.tags.replace(tentative_tags)
  end

  def tags_build
    (MAX_TAGS - taggings.length).times do
      tags.build
    end
  end
end
