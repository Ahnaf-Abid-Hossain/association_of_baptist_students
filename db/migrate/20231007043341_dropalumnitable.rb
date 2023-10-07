class Dropalumnitable < ActiveRecord::Migration[7.0]
  def change
    drop_table :alumnis
  end
end
