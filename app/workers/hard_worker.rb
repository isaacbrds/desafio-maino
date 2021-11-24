class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default 
  
  def perform(*args)
    # Do something
    puts "Running"
  end
end
