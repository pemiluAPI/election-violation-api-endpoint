class ElectionViolationTag < ActiveRecord::Base  
  belongs_to :election_violation, foreign_key: :id_laporan
end