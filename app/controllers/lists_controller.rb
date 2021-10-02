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
	      redirect_to @list
	    else
	      render :new
	    end
	end

	def show
    	@list = List.find(params[:id])
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
