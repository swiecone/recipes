class IngredientsController < ApplicationController
	
	def show
		@ingredient = Ingredient.find(params[:id])
		@recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 2 )
	end 

	def new
		@ingredient = Ingredient.new
	end 

	def create
		@ingredient = Ingredient.new(ingredient_params)
		if @ingredient.save
			flash[:success] = "Ingredient was created successfuly"
			redirect_to recipes_path
		else
			render 'new'
		end 
	end 

private
	def ingredient_params
		params.require(:ingredient).permit(:name)
	end
end 
