class ArticlesController < ApplicationController
	def new
		@article = Article.new
	end
 # method for saving new article posted in database
	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to @article
		else 
			render 'new'
		end
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
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
#method to delete any existing article 
  def destroy
   @article = Article.find(params[:id])
  @article.destroy
 
  redirect_to articles_path
  end

	private
# method to give the attributes permitted to post an article
	def article_params
			params.require(:article).permit(:title, :text)
	end
end
