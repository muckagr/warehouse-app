class ChangeColumnsNameToEnglish < ActiveRecord::Migration[7.0]
  def change
    rename_column :warehouses, :nome, :name
    rename_column :warehouses, :codigo, :code
    rename_column :warehouses, :endereco, :adress
    rename_column :warehouses, :cidade, :city
    rename_column :warehouses, :descricao, :description
  end
end
