class PostObserver < ActiveRecord::Observer
  observe :post

  def after_create(post)
    # This is where we would send an email to the author of the post
    post.notes.create(body: "Auto-generated note for #{post.class.name.downcase}!: #{Date.current}")
  end
end
