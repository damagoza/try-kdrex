class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :defaul => ''

      t.timestamps null: false
    end
  end
end
