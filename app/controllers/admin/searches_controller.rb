class Admin::SearchesController < ApplicationController
  def search
    @model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'end_user'
			@records = EndUser.search_for(@content, @method)
		else
			@records = Schedule.search_for(@content, @method)
		end
  end
end
