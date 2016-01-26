# == Schema Information
#
# Table name: documents
#
#  id                    :integer          not null, primary key
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  email                 :string
#

class Document < ActiveRecord::Base
  has_attached_file :document, path: ':rails_root/public/system/uploads/:attachment/:id/:filename', url: '/system/uploads/:attachment/:id/:filename'
  validates_attachment :document, content_type: { content_type: 'application/pdf' }, presence: true

  def path
    document.path
  end

  def url
    document.url
  end

  def filename
    document_file_name.split('.').first
  end

  def watermark_pdf
    doc = CombinePDF.load(path)
    tmp_doc = 'tmp/watermark.pdf'
    
    Prawn::Document.generate(tmp_doc) do |pdf|
      pdf.repeat :all do
        pdf.fill_color 'D3D3D3'
        pdf.text_box email, align: :center, valign: :center, size: 24, rotate: 45, at: [100, 450]
      end
      
      (doc.pages.count - 1).times do 
        pdf.start_new_page
      end
    end

    CombinePDF.load(tmp_doc)
  end
end
