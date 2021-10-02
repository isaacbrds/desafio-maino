require 'rails_helper'

RSpec.describe "/posts", type: :request do 
    
    before(:each) do
        @current_user = create(:user)
        sign_in @current_user
    end

    
    describe "GET /posts" do
        let(:url) { "/posts/"}
        let!(:posts) {create_list(:post, 6)}
        it "renders a successful response" do 
            get url
            expect(response).to be_successful
        end
    end 
    describe "GET /show" do
        let(:post) {create(:post)}
        let(:url) { "/posts/#{post.id}"}
        it "renders a successful response" do
          get url
          expect(response).to be_successful
        end
    end
    describe "GET /new" do
        let(:url) { "/posts/new"}
        it "renders a successful response" do
          get url
          expect(response).to be_successful
        end
    end

    describe "POST /users" do
        
        context "with valid parameters" do

            before(:each) do
                @post_attributes = attributes_for(:post)
                post posts_url,params: {post: @post_attributes}
            end

            it "Redirect to new post" do
                expect(response).to have_http_status(302)
                expect(response.body).to redirect_to(posts_url)
            end

            it "Create post with right attributes" do
                expect(Post.last.title).to eql(@post_attributes[:title])            
            end
        end
        
        context "with invalid parameters" do
            before(:each) do
                @post_attributes = attributes_for(:post, title: nil)
                post posts_url,params: {post: @post_attributes}
            end
            it "No redirect" do
                expect(response).to have_http_status(200)
                expect(response.body).to include('title')
            end

            it "does not create a new post" do
                expect {
                  post posts_url, params: { post:  @post_attributes }
                }.to change(Post, :count).by(0)
              end
        end
      end



    describe "GET /edit" do
        let!(:post){ create(:post) }
        let(:url) { "/posts/#{post.id}/edit"}
           

        it "render a successful response" do
            get url
            expect(response).to be_successful
        end
    end

    describe "PATCH /users" do
        context "with valid parameters" do
            before(:each) do
                post = create(:post)
                @new_post_attributes = attributes_for(:post)
                
                patch "/posts/#{post.id}", params: {post: @new_post_attributes}
            end
        
            it "returns http success" do
                expect(response).to have_http_status(302)
            end
    
            it "Post have the new attributes" do
                expect(Post.last.title).to eq(@new_post_attributes[:title])
            end
        end

        context "with invalid parameters" do
            before(:each) do
                post = create(:post)
                @new_post_attributes = attributes_for(:post, title: nil)
                put post_url(post), params: {post: @new_post_attributes}
            end
        
            it "returns http success" do
                expect(response).to have_http_status(200)
            end
    
            it "User have the new attributes" do
                expect(Post.last.title).to_not eq(@new_post_attributes[:title])
            end
        end
    end

    describe "DESTROY /posts" do 
        let!(:post){ create(:post) }
        let(:url) { "/posts/#{post.id}"}
        it "removes post" do 
            expect do 
                delete url
            end.to change(Post, :count).by(-1)
        end

        it 'returns success status' do
            delete url
            expect(response).to have_http_status(302)
        end
    end
end