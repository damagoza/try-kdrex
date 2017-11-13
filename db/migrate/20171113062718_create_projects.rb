class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :defaul => ''
      t.references :user, index: true, foreign_key: true
      t.date :start_project
      t.date :end_project
      t.boolean :active, :default => false
      t.timestamps null: false
    end
  end
end
