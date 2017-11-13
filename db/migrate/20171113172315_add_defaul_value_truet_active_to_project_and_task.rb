class AddDefaulValueTruetActiveToProjectAndTask < ActiveRecord::Migration
  def change
  	change_column :projects, :active, :boolean, :default => true
  	change_column :tasks, :active, :boolean, :default => true
  end
end
