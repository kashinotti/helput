require 'rails_helper'
describe "users/posts", type: :request do
  context "新規投稿ページが正しく表示される" do
    before do
      get new_post_path 
    end
    it "リクエストは200 OKとなること" do
      expect(responce.status).to eq 200
    end
    it "タイトルが正しく表示されているか" do
      expect(responce.body).to include("記事の新規投稿")
    end
  end
end