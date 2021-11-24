class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :description
  has_many :comments, dependent:  :destroy
  has_many :tags, dependent:  :destroy
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
  paginates_per 3
  has_one_attached :thumbnail
  validates :thumbnail, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                                     dimension: { width: { min: 500, max: 1920 },
                                                  height: { min: 600, max: 1080 }, message: 'is not given between dimension' }

  validates :title, length: {minimum: 5} 
  
  
  def optimized_image(image,x,y)
    return image.variant(resize_to_fill: [x, y]).processed if image.present?
  end

  def self.import(arquivo)
    
    nome_arquivo = "#{Time.now.to_i}-#{arquivo.original_filename}"
    caminho_do_arquivo = "#{Rails.root}/public/uploads/"
    caminho_com_arquivo = "#{caminho_do_arquivo}#{nome_arquivo}"
    Dir.mkdir(caminho_do_arquivo) unless Dir.exist?(caminho_do_arquivo)
    File.open(caminho_com_arquivo, "wb") do |f|
      f.write(arquivo.read)
    end
    #salvar_no_banco caminho_com_arquivo
    caminho_com_arquivo
  end

  
  
  
  def self.salvar_no_banco arquivo
    open(arquivo) do |file|
      
      file.each_with_index do |linha, i|
        next if i == 0
        post = self.new(title: "#{linha}-#{i}", user_id: 1, thumbnail: Rack::Test::UploadedFile.new(Rails.root.join("spec/support/images/avatar.png")))
        
        post.save
      end
    end
    true
    
  end  
end
