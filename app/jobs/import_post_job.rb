class ImportPostJob < ApplicationJob
  queue_as :import_post

  def perform(arquivo)
    @arquivo = arquivo 
    Post.salvar_no_banco(@arquivo)
  end

end
