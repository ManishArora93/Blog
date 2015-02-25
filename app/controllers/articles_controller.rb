class ArticlesController < ApplicationController
	def new
		@article = Article.new
	end
 # method for saving new article posted in database
	def create
		
		
		# p "i am comming here"
		# @article = Article.new(article_params)
		# p ">>>>>>>>>>>"
		# p article_params
		# p @article
		# if @article.save
		#  	redirect_to @article
		# else 
		# 	render 'new'
		# end
		  @article = current_user.articles.create(article_params)
		  redirect_to @article
		  p params
		 # p @user
		 # @article = @user.articles.create
		 # p ">>>>>>>>>>>>"
		 # p @article 
		 # p "<<<<<<<<<<<<<<"
		 # redirect_to @article

	end
 #method to populate the existing article in update view
	def edit
  	@article = Article.find(params[:id])
	end
 # method to display the posted article
	def show
		@article = Article.find(params[:id])
		p @article
	end

	def index
     @articles= Article.paginate(:page => params[:page], :per_page => 5)
  end
#method for editing the existing article
  def update
    @article = Article.find(params[:id])
 
    if @article.user_id===current_user.id
       @article.update(article_params)
       redirect_to @article
    else
       redirect_to article_path, :alert => "You are not authorised to update this post!"

    end
  end
#method to delete any existing article 
  def destroy
  @article = Article.find(params[:id])
    p @article.user_id
    p current_user.id
  	if @article.user_id===current_user.id
     	@article.destroy
     	redirect_to articles_path
    else 
    	 redirect_to article_path, :alert => "You are not authorised to delete this post!"
    end
  end

	private
# method to give the attributes permitted to post an article
	def article_params
			params.require(:article).permit(:title, :text,:user_id)
	end
end
