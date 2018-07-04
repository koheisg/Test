class AddIndexToIdentitiesProviderUid < ActiveRecord::Migration[5.1]
  def change
      add_index :identities, [:provider, :uid], unique: true
  end
end
