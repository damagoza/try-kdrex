class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, :default => ''
      t.references :project, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.date :start_task
      t.date :end_task
      t.boolean :active, :default => false

      t.timestamps null: false
    end
  end
end
