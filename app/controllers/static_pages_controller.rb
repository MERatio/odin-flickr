class StaticPagesController < ApplicationController
  def home
    # 69498982@N03  - erik
    # 188496746@N08 - me
    # [{"id"=>"49893112347", "owner"=>"188496746@N08", "secret"=>"0ab51f4e42", "server"=>"65535", "farm"=>66, "title"=>"kitten-3", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}, 
    # {"id"=>"49892285543", "owner"=>"188496746@N08", "secret"=>"ce06f2e3c3", "server"=>"65535", "farm"=>66, "title"=>"kitten-2", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}, 
    # {"id"=>"49892285943", "owner"=>"188496746@N08", "secret"=>"d9c9a8d2b0", "server"=>"65535", "farm"=>66, "title"=>"kitten-1", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}]
    find_user_photos
  end

  private

    def init_flickraw
      FlickRaw.api_key = ENV['ODIN_FLICKR_KEY']
      FlickRaw.shared_secret = ENV['ODIN_FLICKR_SECRET']
      @flickr = FlickRaw::Flickr.new
    end

    def find_user_photos
      begin
        if params[:user]
          init_flickraw
          @user = params[:user][:id]
          @photos = flickr.photos.search(user_id: @user)
                          .to_a.paginate(page: params[:page], per_page: 10)
        end
      rescue FlickRaw::FailedResponse
        flash[:danger] = 'Flickr user does not exist'
        redirect_to root_path
      end
    end
end
