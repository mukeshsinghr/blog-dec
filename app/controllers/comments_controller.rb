class CommentsController < ApplicationController
	
	def create
		puts "Inside CommentsController.create : #{params}"	

		@post = Post.find(params[:post_id])
		if @post.comments.create(comment_params)
			flash[:notice] = "Comment created successfully"
			
		else
			flash[:error] = "failed to create comment"
		end
		#render :text => 'no page defined'
		redirect_to @post
	end

	def comment_params
		params.require(:comment).permit(:body)
	end

end
