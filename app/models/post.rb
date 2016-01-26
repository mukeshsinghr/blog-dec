class Post < ActiveRecord::Base
	validates :title, :presence => true

	before_validation :callback1
	around_save :audit_post_creation
	before_destroy :delete_logs

	has_many :comments, :dependent => :destroy

	def callback1
		puts "This will be called before validations"
	end

	def audit_post_creation
		
		puts "Post state before save"
			yield
		puts "Post state after creating  a post"
	end

		
	def delete_logs
		puts "This will be called while deleting the post"
	end
end
