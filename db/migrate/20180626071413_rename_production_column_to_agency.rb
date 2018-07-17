class RenameProductionColumnToAgency < ActiveRecord::Migration[5.1]
  def change
  	rename_column :geinins, :production, :agency
  end
end
