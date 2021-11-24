class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default 
  
  def perform(*args)
    # Do something
    
    puts "Running nesse kraio puta que pariu"
    true
  end
end
