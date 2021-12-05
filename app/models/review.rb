class Review < ApplicationRecord	
	belongs_to :user
	has_rich_text :content
	acts_as_taggable_on :tags

	include PgSearch::Model
	pg_search_scope :global_search, against: [:title, :rating], associated_against: {user: :username, rich_text_content: :body, tags: :name}, using: { tsearch: { prefix: true } }
	#pg_search_scope :global_search, against: [:title], using: { tsearch: { prefix: true } }
end
