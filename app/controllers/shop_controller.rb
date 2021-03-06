class ShopController < ApplicationController
  include SessionsHelper
  
  def index
    @title = "All books"
	@cart = get_cart
    # @books = Book.find_books_for_sale
	@books = Book.paginate(:page => params[:books_page], :per_page => 5)
  end

  def add_to_cart
    @cart = get_cart
    @cart.add_to_cart(Book.find(params[:id]))
	@books = Book.paginate(:page => params[:books_page], :per_page => 5)
	respond_to do |format|
	  format.html { render :action => "index" }
	  format.js
      format.xml  { render :xml => @book, :status => :created, :location => @book }
	end
  end
  
	def watch_video
		puts '*********************************'
		@book = Book.find(params[:id])
		respond_to do |format|
			# format.html { render :action => "watch_video" }
			# format.html { redirect_to watch_video.html.erb }
			format.html
      format.xml  { render :xml => @book }
		end
  end
	
  # Uses model to perform search
  def books_search
    @query = params[:query]
    @books = Book.search(@query)
	@books = @books.paginate(:page => params[:books_page], :per_page => 5)
	@cart = get_cart

	respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @books }
    end
  end
  
  # Uses the model to search through authors
  def authors_search
    @query = params[:query]
    @authors = Author.search(@query)
	@books = []
	if !@authors.empty?  
	  @authors.each do |author|
	    puts author.last_name
	    author.books.each do |book|
		  puts book.title
	      @books << book unless @books.include?(book)
	    end
	  end
	end
	@books = @books.paginate(:page => params[:books_page], :per_page => 5)
	@cart = get_cart
	
	respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @authors }
    end
  end
  
end