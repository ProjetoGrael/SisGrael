class AddAttributesToServiceSheets < ActiveRecord::Migration[5.1]
  def change
    add_column :service_sheets, :psychological_support, :boolean
    add_column :service_sheets, :psychological_support_info, :text
  end
end
