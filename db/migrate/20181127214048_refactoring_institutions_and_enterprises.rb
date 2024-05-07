class RefactoringInstitutionsAndEnterprises < ActiveRecord::Migration[5.1]
  def change
    change_table :transactions do |t|
      t.remove :responsible_id, :responsible_type
      t.references :payer
      t.references :receiver
      
    end 
  end
end
