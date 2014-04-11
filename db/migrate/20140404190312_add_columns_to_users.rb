class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parent, :integer
    add_column :users, :description, :string
    add_column :users, :image, :string
    add_column :users, :phone, :string
    add_column :users, :template_name, :string
    add_column :users, :href, :string
    add_column :users, :color, :string
  end
end
