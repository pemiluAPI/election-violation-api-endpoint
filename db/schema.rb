# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140604085316) do

  create_table "election_violation_tags", force: true do |t|
    t.string "id_laporan"
    t.string "tag"
  end

  create_table "election_violations", force: true do |t|
    t.string "judul_laporan"
    t.string "tanggal_kejadian"
    t.string "alamat"
    t.string "kelurahan_desa"
    t.string "kecamatan"
    t.string "kab_kota"
    t.string "provinsi"
    t.text   "keterangan"
    t.string "kategori"
    t.string "status"
  end

end
