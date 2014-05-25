class CreateNoticias < ActiveRecord::Migration
  def change
    create_table :noticias do |t|
      t.string :titulo
      t.text :corpo

      t.timestamps
    end
  end
end
