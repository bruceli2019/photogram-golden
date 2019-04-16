class PicturesController < ApplicationController
    
    #create photos
    def new_photo_form
        render("pic_templates/new_photo_form.html.erb")
    end

    def new_photo_actual
        
        # hash is gotten from submitting something into my new_photo_form and then reading the Rails console for what was executed in the form
        # the hash is params = {"new_img_url" => "something", "new_caption" => "somethingelse"}
        @new_photo_url = params["new_img_url"]
        @new_photo_caption = params["new_caption"]
        
        #creates a new photo
        photo = Photo.new
        
        #recall the photos are stored as a hash with the following keys: id, source, caption, created_at, updated_at
        
        photo.source = @new_photo_url
        photo.caption = @new_photo_caption
        
        curr_time = Time.now
        
        photo.created_at = curr_time
        photo.updated_at = curr_time
        
        #must always save the photo
        photo.save
        
        #get the number of saved photos, do this after we add the new photo
        @photo_count = Photo.count
        
        # we send the user immediately back to the index page after they create new photo with a redirect, can just use the /photos
        redirect_to("/photos")
    end
    
    #read photos
    def index
        #remember, the class is Photo, not Photos! -- this is a database table
        
        # sorts the photo list by updated times, descending
        @photo_list = Photo.all.order(updated_at: :desc)
        
        render("pic_templates/all_photos.html.erb")
    end
    
    def read_photo
        
        # note that all the inputs are stored as a hash similar to
        # params = {"photo_id" => "2"}
        
        # the key I chose was photo_id, this is a string that I convert to int
        @curr_photo_id = params["photo_id"].to_i
        # extract the actual photo from the Photo class
        @photo_hash = Photo.find(@curr_photo_id)
        
        render("pic_templates/read_photo.html.erb")
    end
    
    #edit photos
    def edit_photo_form
        # the params hash, gotten from running the form in my browser and looking into the Ruby console, is params = {"photo_id" => "2"}
        # need to convert to integer
        @edit_photo_id = params["photo_id"].to_i

        # Photo is a database, we retrieve stuff with a .find
        @photo_hash = Photo.find(@edit_photo_id)
        
        @photo_url = @photo_hash["source"]
        @photo_caption = @photo_hash["caption"]
        
        render("pic_templates/edit_photo_form.html.erb")
    end
    
    def edit_photo_actual
        # the hash is params = {"edit_img_url" => "someurl", "edit_img_caption" => "caption", "photo_id" => "someid"}
        
        @edit_photo_id = params["photo_id"].to_i
        
        #do the actual updating here
        edit_photo = Photo.find(@edit_photo_id)
        
        #I'm not sure why the captions are always prepopulating with the old stuff
        edit_photo.source = params["edit_img_url"]
        edit_photo.caption = params["edit_img_caption"]
        
        # we need to update the time for updated_at
        curr_time = Time.now
        
        edit_photo.updated_at = curr_time
        
        #save the photo
        edit_photo.save
        
        #reconvert everything to string
        redirect_to("/photos/"+@edit_photo_id.to_s)
    end
    
    #delete photos
    def delete_photo
        # params = {"photo_id" => "9"}
        
        @delete_photo_id = params["photo_id"].to_i
        
        #delete stuff in table with .destroy
        @delete_photo = Photo.find(@delete_photo_id)
        
        #deletes the photo
        @delete_photo.destroy
        
        #count number of photos surviving
        @new_num_photos = Photo.count
        
        redirect_to("/photos")
    end
    
end