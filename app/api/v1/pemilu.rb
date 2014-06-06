module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :reports do     
      
      desc "Return all Election Violations"
      get do
        reports = Array.new
        tags = params[:tags].split(',') unless params[:tags].nil?
        
        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 1000 : params[:limit]
        
        unless params[:tags].nil?
          arr_tags = Array.new
          tags.each do |tag|
            arr_tags << tag.tr("_", " ")
          end
          tags_search = ["election_violation_tags.tag in (?)", arr_tags]
        end
        
        ElectionViolation.includes(:election_violation_tags)          
          .where(tags_search)
          .references(:election_violation_tags)
          .limit(limit)
          .offset(params[:offset])
          .order("str_to_date(tanggal_kejadian,'%Y-%m-%dd') desc")
          .each do |report|
            tags_collection = params[:tags].nil? ? report.election_violation_tags : ElectionViolationTag.where("id_laporan = ?", report.id)
            reports << {
              id: report.id,
              judul_laporan: report.judul_laporan,
              tanggal_kejadian: report.tanggal_kejadian,
              alamat: report.alamat,
              kelurahan_desa: report.kelurahan_desa,
              kecamatan: report.kecamatan,
              kab_kota: report.kab_kota,
              provinsi: report.provinsi,
              keterangan: report.keterangan,
              kategori: report.kategori,
              status: report.status,
              tags: tags_collection.map { |tag| tag.tag }
            }
          end
          {
          results: {
            count: reports.count,
            total: ElectionViolation.includes(:election_violation_tags).where(tags_search).references(:election_violation_tags).count,
            reports: reports
          }
        }
      end
      
      desc "Return a single Election Violation object with all its details"
      params do
        requires :id, type: String, desc: "Election Violation ID."
      end
      route_param :id do
        get do
          report = ElectionViolation.find_by(id: params[:id])
          {
            results: {
              count: 1,
              total: 1,
              report: [{
                id: report.id,
                judul_laporan: report.judul_laporan,
                tanggal_kejadian: report.tanggal_kejadian,
                alamat: report.alamat,
                kelurahan_desa: report.kelurahan_desa,
                kecamatan: report.kecamatan,
                kab_kota: report.kab_kota,
                provinsi: report.provinsi,
                keterangan: report.keterangan,
                kategori: report.kategori,
                status: report.status,
                tags: report.election_violation_tags.map { |tag| tag.tag }
              }]
            }
          }
        end
      end
    end
    
    resource :tags do
      desc 'return a list of Election Violation Tags objects'
      get do
        tags = Array.new
        ElectionViolationTag.group('tag').count.each do |field|
          tags << {
            tag: field[0],
            report_count: field[1]
          }
        end
        {
          results: {
            count: tags.count,
            tags: tags
          }
        }
      end
    end
  end
end