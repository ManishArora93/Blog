class CommentsController < ApplicationController
#to provide security to several authorised actions on comments

# method to add a comment on an article
  def create
     @article = Article.find(params[:article_id])
     @comment = @article.comments.create(comment_params)
     redirect_to article_path(@article)
  end
#method to delete a comment on article
  def destroy
     @article = Article.find(params[:article_id])
     @comment = @article.comments.find(params[:id])
     @comment.destroy
     redirect_to article_path(@article)
  end
 
 
private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
