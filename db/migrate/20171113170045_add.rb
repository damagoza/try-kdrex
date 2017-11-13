class Add < ActiveRecord::Migration
  def change
  	add_column :projects, :description, :string, :default => ''
  	add_column :tasks, :description, :string, :default => ''
  end
end
