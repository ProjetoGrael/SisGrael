class RemovePartnerFromTeachers < ActiveRecord::Migration[5.1]
  def change
    change_table :teachers do |t|
      t.remove :partner_name
      t.remove :partner_cpf
      t.remove :partner_email
      t.remove :partner_phone
    end
  end
end
