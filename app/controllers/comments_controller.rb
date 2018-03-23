class CommentsController < ApplicationController

before_action :authorize, :only => [:create]
before_action :admin_authorize, :only => [:destroy]

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		if @comment.save
			redirect_to article_path(@article), notice:
			"Comment Successfully!"
		else 
			redirect_to article_path(@article), alert:
			"Fail to Comment..."		
		end
	end

	def destroy
		#for admin authorization
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article)
	end

private 
	def comment_params
		params.require(:comment).permit(:commenter,:body )
	end
end
