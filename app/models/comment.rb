class Comment < ActiveRecord::Base
	belongs_to :post, :foreign_key => "post_id"
end
