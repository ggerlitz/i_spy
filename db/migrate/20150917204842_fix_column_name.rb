class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :fnames, :fname 
  end
end
