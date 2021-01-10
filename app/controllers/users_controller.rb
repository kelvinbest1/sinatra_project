class UsersController < ApplicationController
# GET: /let the user go for the sign-up page --done
get "/signup" do
  if signed_in?
    redirect '/routines'
  else
    erb :"/users/new.html"
  end
end


post "/signin" do
  @user = User.find_by(:name => params[:name])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/routines'
  else
    redirect "/signup"
  end
end

post "/signup" do
 
  if params[:name].empty? || params[:email].empty? || params[:password].empty?
    redirect "/signup"
  else
    
    @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password])
    # @user.save
    session[:user_id] = @user.id
    redirect "/routines"
  end
end
    get '/users' do
      if signed_in?
       
        @user = User.find(session[:user_id])
       
          erb :"users/show.html"
      else
        redirect "/signin"
      end
    end
    get '/users/:id' do
      if signed_in?
        @user = User.find(params[:id])
       
        erb :'/users/show.html'
      else
        redirect '/signin'
      end
    end
    
    get "/signin" do
      if signed_in?
        redirect '/routines'
      else
        erb :"/users/signin.html"
      end
    end
  
    
    get "/signout" do
    
      if signed_in?
        session.destroy
        redirect "/signin"
      else
        redirect "/index"
      end
    end
  

    get "/users/:id/edit" do
      @user = User.find_by(id: session[:user_id])
      if @user
  
      
      erb :"/users/edit.html"
      else
        redirect "/signin"
      end
    end
    patch '/users/:id' do
      
      if signed_in?
        if params[:name].empty?
          
          redirect "/users/#{params[:id]}/edit"
        else
          @user = User.find_by_id(params[:id])
          if @user == current_user
            if @user.update(:name => params[:name], :email => params[:email])
              redirect to "/users/#{@user.id}"
            else
            redirect to "/users/#{@user.id}/edit"
            end
          else
            redirect to '/users'
          end
        end
      else
        redirect '/signin'
      end
    end
    
  end