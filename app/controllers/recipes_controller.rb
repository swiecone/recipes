class RecipesController < ApplicationController
	before_action :set_recipe, only: [:edit, :update, :show, :like]
	before_action :require_user, except: [:show, :index, :like]
	before_action :require_user_like, only: [:like]
	before_action  :require_same_user, only: [:update, :edit]
	before_action :admin_user, only: :destroy 

	def index 
		@recipes = Recipe.paginate(:page => params[:page], :per_page => 4)
	end 

	def show

	end 

def new 
	@recipe = Recipe.new
end 

def create 
	@recipe = Recipe.new(recipe_params)
	@recipe.chef = current_user

	if @recipe.save
		flash[:success] = "Your recipe was created successfuly!"
		redirect_to recipes_path
	else
		render :new
	end
end 

def edit

end 

def update
	if @recipe.update(recipe_params)
			#do something
		flash[:success] = "Your recipe was updated successfully"
		redirect_to recipes_path(@recipe)
	else
		render :edit
	end  
end 

def like
	like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
	if like.valid?
		flash[:success] = "Your selection was successful"
		redirect_to :back
	else 
		flash[:danger] = "You can only like/dislike recipe once"
		redirect_to :back
	end

end

def destroy 
	@destroyed_recipe = Recipe.find(params[:id]).destroy
	flash[:success] = "\'#{@destroyed_recipe.name}\' recipe was deleted."
	redirect_to recipes_path
end 


private 

	def recipe_params
		params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
	end 

	def set_recipe
		@recipe = Recipe.find(params[:id])
	end 

	def require_same_user
		if current_user.admin? 
			flash[:success] = " #{current_user.chefname}, you can  edit the recipe as you are admin."
			#redirect_to edit_recipe_path
		elsif current_user != @recipe.chef
			flash[:danger] = " #{current_user.chefname}, you can only edit your own recipes!"
			redirect_to recipes_path
		else
			#render 'new'
		end 
	end 

	def require_user_like
  		if !logged_in?
  			flash[:danger] = "Please log in order to like/dislike a recipe!"
  			redirect_to :back
  		end 
  	end 

  	def admin_user
  		redirect_to recipes_path unless current_user.admin?
  	end 

end 