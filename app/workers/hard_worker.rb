require "json"
class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default 
  
  def perform(*args)
    title = args[0]
    user_id = args[1]
    
    post = Post.new(title: title, user_id: user_id, thumbnail: Rack::Test::UploadedFile.new(Rails.root.join("spec/support/images/avatar.png")))
    puts "#{post.title} - #{post.user_id}" 
    post.save
    true
  end
end
