require 'spec_helper'

describe ShelvesController do
  fixtures :all

  describe "GET index" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns all shelves as @shelves" do
        get :index
        assigns(:shelves).should eq(Shelf.paginate(:page => 1))
      end
    end

    describe "When not logged in" do
      it "assigns all shelves as @shelves" do
        get :index
        assigns(:shelves).should eq(Shelf.paginate(:page => 1))
      end
    end
  end

  describe "GET show" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns the requested shelf as @shelf" do
        get :show, :id => 1
        assigns(:shelf).should eq(Shelf.find(1))
      end
    end

    describe "When not logged in" do
      it "assigns the requested shelf as @shelf" do
        get :show, :id => 1
        assigns(:shelf).should eq(Shelf.find(1))
      end
    end
  end

  describe "GET new" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns the requested shelf as @shelf" do
        get :new
        assigns(:shelf).should_not be_valid
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      it "assigns the requested shelf as @shelf" do
        get :new
        assigns(:shelf).should_not be_valid
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      it "should not assign the requested shelf as @shelf" do
        get :new
        assigns(:shelf).should_not be_valid
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested shelf as @shelf" do
        get :new
        assigns(:shelf).should_not be_valid
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET edit" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns the requested shelf as @shelf" do
        shelf = Factory.create(:shelf)
        get :edit, :id => shelf.id
        assigns(:shelf).should eq(shelf)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      it "assigns the requested shelf as @shelf" do
        shelf = Factory.create(:shelf)
        get :edit, :id => shelf.id
        assigns(:shelf).should eq(shelf)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      it "assigns the requested shelf as @shelf" do
        shelf = Factory.create(:shelf)
        get :edit, :id => shelf.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested shelf as @shelf" do
        shelf = Factory.create(:shelf)
        get :edit, :id => shelf.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
