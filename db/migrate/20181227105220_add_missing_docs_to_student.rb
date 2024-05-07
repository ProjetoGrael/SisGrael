class AddMissingDocsToStudent < ActiveRecord::Migration[5.1]
  def change
    change_table :students do |t|
      t.boolean :rg_missing
      t.boolean :cpf_missing
      t.boolean :responsible_rg_missing
      t.boolean :responsible_cpf_missing
      t.boolean :address_proof_missing
      t.boolean :term_signed_missing
      t.boolean :school_declaration_missing
      t.boolean :medical_certificate_missing
      t.boolean :birth_certificate_missing
      t.boolean :historic_missing
    end
  end
end
