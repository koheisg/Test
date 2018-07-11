class AddGeneralSaleToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :general_sale, :datetime
    add_column :events, :presale_start, :datetime
    add_column :events, :presale_end, :datetime
  end
end
