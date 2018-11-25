class BooksController < ApplicationController


	def new
	end

	def create
		@book_show = Book.new(book_params)
		@book_show.user_id = current_user.id
		@user = current_user
		if @book_show.save
		flash[:notice] = "Book was successfully saved"
		redirect_to book_path(@book_show)
	    else
	 	 @books =Book.all
	 	 render 'index'
	 	end
	end

	def index
		@user = User.find(current_user.id)
		@book_show = Book.new
		@books = Book.all
	end

	def show
		@book_show = Book.new
		@book = Book.find(params[:id])
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to user_path(current_user)
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		flash[:notice] = "Book was successfully edited"
	    redirect_to book_path(@book.id)
	    else
	    render 'edit'
	    end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

private
def book_params
	params.require(:book).permit(:title, :opinion)
end

end
