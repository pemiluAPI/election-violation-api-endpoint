class ElectionViolation < ActiveRecord::Base  
  has_many :election_violation_tags, foreign_key: :id_laporan
end