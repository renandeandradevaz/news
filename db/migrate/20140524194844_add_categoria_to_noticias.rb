class AddCategoriaToNoticias < ActiveRecord::Migration
  def change
    add_column :noticias, :categoria, :string
  end
end
