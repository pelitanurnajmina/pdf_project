class ListsController < ApplicationController
	def index
  		@lists = List.all
	end

	def new
    	@list = List.new
	end

	def create
    	uploaded_file = params[:list][:filename]
    	File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
    		file.write(uploaded_file.read)
    	end

    	@list = List.new(title: params[:list][:title], filename: uploaded_file.original_filename)

	    if @list.save
	      redirect_to root_path
	    else
	      render :new
	    end
	end

	def show
    	@list = List.find(params[:id])

    	@text = List.select('lists.*','attribute_type','value','coordinate')
    			.joins('INNER JOIN details ON details.list_id = lists.id')
    			.where('lists.id' => params[:id])
    			.where('details.attribute_type' => 'text')
    			.order('details.created_at DESC')
    			.first

    	@picture = List.select('lists.*','attribute_type','value','coordinate')
    			.joins('INNER JOIN details ON details.list_id = lists.id')
    			.where('lists.id' => params[:id])
    			.where('details.attribute_type' => 'picture')
    			.order('details.created_at DESC')
    			.first
	end

	def edit
    	@list = List.find(params[:id])
  	end

  	def update
  		@list = List.find(params[:id])

	    if @list.update(list_params)
	      	redirect_to @list
	    else
	      	render :edit
	    end
  	end

  	def destroy
	    @list = List.find(params[:id])
	    @list.destroy

	    redirect_to root_path
	end

	private
	    def list_params
	      params.require(:list).permit(:title, :filename)
	    end
end
