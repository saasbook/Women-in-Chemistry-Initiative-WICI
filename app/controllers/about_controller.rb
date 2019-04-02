class AboutController < ApplicationController
	def index
		respond_to do |format|
			format.html { render :show }
		end
	end
end