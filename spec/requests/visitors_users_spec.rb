require 'rails_helper'

RSpec.describe "/posts", type: :request do 
  
    
    describe "GET /" do
        let(:url) { "/posts/"}
        let!(:posts) {create_list(:post, 6)}
        it "renders a successful response" do 
            get url
            expect(response).to have_http_status(302)
        end
    end 
    describe "GET /show" do
        let(:post) {create(:post)}
        
        let(:url) { "/posts/#{post.id}"}
        it "renders a successful response" do
          get url
          expect(response).to have_http_status(200)
        end        
    end
    describe "GET /new" do
        let(:url) { "/posts/new"}
        it "renders a successful response" do
          get url
          expect(response).to have_http_status(302)
        end
    end
    describe "GET /edit" do
        let!(:post) {create(:post)}
        let(:url) { "/posts/#{post.id}/edit"}
           

        it "render a successful response" do
            get url
            expect(response).to have_http_status(302)
        end
    end

    describe "DESTROY /posts" do 
        let!(:post){ create(:post) }
        let(:url) { "/posts/#{post.id}"}
        it "removes user" do 
            expect do 
                delete url
            end.to change(User, :count).by(0)
        end

        it 'returns success status' do
            delete url
            expect(response).to have_http_status(302)
        end
    end
end