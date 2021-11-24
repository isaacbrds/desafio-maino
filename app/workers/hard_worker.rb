class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default 
  
  def perform(*args)
    
    @arquivo = args[0]
    Post.salvar_no_banco(@arquivo)
    true
  end
end
