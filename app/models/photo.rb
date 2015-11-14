# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  has_attached_file :image,
  styles: { thumb: ["64x64#", :jpg], original: ['500x500>', :jpg] },
  convert_options: { thumb: "-quality 75 -strip", original: "-quality 85 -strip" },
  ## LOCAL FILE
  # path: ':rails_root/public/system/uploads/:attachment/:id/:style/:filename',
  # url: '/system/uploads/:attachment/:id/:style/:filename'
  ## DROPBOX
  # storage: :dropbox,
  # dropbox_credentials: Rails.root.join('config', 'dropbox.yml'),
  # dropbox_visibility: 'private',
  # path: 'App/ShirjeelPlayground/:id/:style/:filename'
  ## S3
  storage: :s3,
  s3_credentials: Rails.root.join('config','aws.yml')

  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
