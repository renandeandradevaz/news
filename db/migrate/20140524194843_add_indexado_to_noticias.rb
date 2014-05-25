class AddIndexadoToNoticias < ActiveRecord::Migration
  def change
    add_column :noticias, :indexado_no_elasticsearch, :boolean
  end
end
