class PhotoObserver < ActiveRecord::Observer
  observe :photo

  def after_create(photo)
    # This is where we would send an email to the author of the photo
    photo.notes.create(body: "Auto-generated note for #{photo.class.name.downcase}!: #{Date.current}")
  end
end
