class AddHiringKindToLaborMarket < ActiveRecord::Migration[5.1]
  def change
    add_column :labor_markets, :hiring_kind, :string
  end
end
