module StaticPagesHelper
  def photo_url(photo)
    "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}.jpg"
  end
end
