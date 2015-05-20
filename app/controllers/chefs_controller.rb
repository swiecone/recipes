class ChefsController < ApplicationController

	def new
		@chef = Chef.create()
	end 

end 