require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase
  setup do
    @author = authors(:one)
	@author_bad = Author.new(:first_name => "123", :last_name => "Last")
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author" do
    assert_difference('Author.count') do
      post :create, :author => @author.attributes
    end

    assert_redirected_to author_path(assigns(:author))
  end

  test "should show author" do
    get :show, :id => @author.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @author.to_param
    assert_response :success
  end

  test "should update author" do
    put :update, :id => @author.to_param, :author => @author.attributes
    assert_redirected_to author_path(assigns(:author))
  end

  test "should not update author" do
    put :update, :id => @author.to_param, :author => @author_bad.attributes
    assert_equal @author.first_name, "MyString"
  end
  
  test "should not create 2 authors" do
    assert_difference('Author.count') do
      post :create, :author => @author.attributes
    end
    assert_redirected_to author_path(assigns(:author))
	
    num = Author.count
	post :create, :author => @author.attributes
	assert_equal num, Author.count
  end
  
  test "should destroy author" do
    assert_difference('Author.count', -1) do
      delete :destroy, :id => @author.to_param
    end

    assert_redirected_to authors_path
  end
  
  test "should not destroy author" do
    @book = books(:book1)
	@author.books << @book
	assert_difference('Author.count', 0) do
      delete :destroy, :id => @author.to_param
    end

    assert_redirected_to authors_path
  end
  
end