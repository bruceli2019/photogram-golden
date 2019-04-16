Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  #put all the routes across the pages
  
  #homepage defaults to photos
  get("/", {:controller => "pictures", :action => "index" })
  
  #create photos
  get("/photos/new", {:controller => "pictures", :action => "new_photo_form"})
  get("/create_photo", {:controller => "pictures", :action => "new_photo_actual"})
  
  #read photos
  get("/photos", {:controller => "pictures", :action => "index" })
  get("/photos/:photo_id", {:controller => "pictures", :action => "read_photo"})
  
  #update photos
  get("/photos/:photo_id/edit", {:controller => "pictures", :action => "edit_photo_form"})
  get("/update_photo/:photo_id", {:controller => "pictures", :action => "edit_photo_actual"})

  #delete photos
  get("/delete_photo/:photo_id", {:controller => "pictures", :action => "delete_photo"})
  
end
