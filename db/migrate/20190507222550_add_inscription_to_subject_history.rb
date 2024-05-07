class AddInscriptionToSubjectHistory < ActiveRecord::Migration[5.1]
  def change
    add_reference :subject_histories, :inscription, foreign_key: true
  end
end
