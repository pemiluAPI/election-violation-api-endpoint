class CreateElectionViolation < ActiveRecord::Migration
  def change
    create_table :election_violations, {id: false} do |t|
      t.string :id
      t.string :judul_laporan
      t.string :tanggal_kejadian
      t.string :alamat
      t.string :kelurahan_desa
      t.string :kecamatan
      t.string :kab_kota
      t.string :provinsi
      t.text :keterangan
      t.string :kategori
      t.string :status
    end
    execute "ALTER TABLE election_violations ADD PRIMARY KEY (id);"
  end
end
