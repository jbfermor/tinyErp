require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/products_returns", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # ProductsReturn. As you add validations to ProductsReturn, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      ProductsReturn.create! valid_attributes
      get products_returns_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      products_return = ProductsReturn.create! valid_attributes
      get products_return_url(products_return)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_products_return_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      products_return = ProductsReturn.create! valid_attributes
      get edit_products_return_url(products_return)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ProductsReturn" do
        expect {
          post products_returns_url, params: { products_return: valid_attributes }
        }.to change(ProductsReturn, :count).by(1)
      end

      it "redirects to the created products_return" do
        post products_returns_url, params: { products_return: valid_attributes }
        expect(response).to redirect_to(products_return_url(ProductsReturn.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ProductsReturn" do
        expect {
          post products_returns_url, params: { products_return: invalid_attributes }
        }.to change(ProductsReturn, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post products_returns_url, params: { products_return: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested products_return" do
        products_return = ProductsReturn.create! valid_attributes
        patch products_return_url(products_return), params: { products_return: new_attributes }
        products_return.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the products_return" do
        products_return = ProductsReturn.create! valid_attributes
        patch products_return_url(products_return), params: { products_return: new_attributes }
        products_return.reload
        expect(response).to redirect_to(products_return_url(products_return))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        products_return = ProductsReturn.create! valid_attributes
        patch products_return_url(products_return), params: { products_return: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested products_return" do
      products_return = ProductsReturn.create! valid_attributes
      expect {
        delete products_return_url(products_return)
      }.to change(ProductsReturn, :count).by(-1)
    end

    it "redirects to the products_returns list" do
      products_return = ProductsReturn.create! valid_attributes
      delete products_return_url(products_return)
      expect(response).to redirect_to(products_returns_url)
    end
  end
end
