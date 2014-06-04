class CreateElectionViolationTag < ActiveRecord::Migration
  def change
    create_table :election_violation_tags do |t|
      t.string :id_laporan
      t.string :tag
    end
  end
end
