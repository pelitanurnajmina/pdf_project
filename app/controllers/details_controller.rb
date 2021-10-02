class DetailsController < ApplicationController
  	def create
		Detail.where('details.list_id' => 1).destroy_all

    	@detail_text = Detail.new(list_id: params[:list_id], 
    						attribute_type: params[:attribute_type],
    						value: params[:value],
    						coordinate: params[:coordinate])

	    @detail_text.save

    	@detail_picture = Detail.new(list_id: params[:list_id], 
    						attribute_type: params[:picture_attribute_type],
    						value: params[:picture_value],
    						coordinate: params[:picture_coordinate])

	    @detail_picture.save

	    redirect_back fallback_location: root_path
	end
end
