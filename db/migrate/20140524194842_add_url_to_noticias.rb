class AddUrlToNoticias < ActiveRecord::Migration
  def change
    add_column :noticias, :url, :string
  end
end
