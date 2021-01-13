class RoutinesController < ApplicationController
    # GET: /routines asking the server for the data in routine -- done
    get "/routines" do
      
      if signed_in?
       
        @user = User.find(session[:user_id])
       
  
          @routines = Routine.where(user_id: current_user)
      
          erb :"routines/index.html"
      else
        redirect "/signin"
      end
    end
  
   
    get "/routines/new" do
      if signed_in?
        @user = User.find_by(id: session[:user_id])
        erb :"/routines/new.html"
      else
        redirect "/signin"
      end
    end
  

    post "/routines" do
    
      if signed_in?
        @user = User.find(session[:user_id])
      
  
        if params[:exercise].empty?
          redirect "/routines/new"
        else
        @user = User.find_by(:id => session[:user_id])
        @routine = Routine.new
        @routine.exercise = params[:exercise]
        @routine.user_id = @user.id
        @routine.save
  
          
          redirect "/routines"
        end
      else
        redirect "/signin"
      end
    end
    get '/routines/:id' do
      if signed_in?
        # @user = User.find_by(id: session[:user_id])
        @routine = Routine.find(params[:id])
        if @routine && @routine.user == current_user
       
        erb :'/routines/show.html'
      else
        redirect "/signin"
      end
      else
        redirect '/signin'
      end
    end
  
    get "/routines/:id/edit" do
      @user = User.find_by(id: session[:user_id])
      @routine = Routine.find(params[:id])
      if @routine && @routine.user == current_user
  
      
      erb :"/routines/edit.html"
      else
        redirect "/routines"
      end
    end
    patch '/routines/:id' do
      if signed_in?
        if params[:exercise].empty?
          redirect "/routines/#{params[:id]}/edit"
        else
          @routine = Routine.find_by_id(params[:id])
          if @routine && @routine.user == current_user
            if @routine.update(:exercise => params[:exercise])
              redirect to "/routines/#{@routine.id}"
            else
            redirect to "/routines/#{@routine.id}/edit"
            end
          else
            redirect to '/routines'
          end
        end
      else
        redirect '/signin'
      end
    end
  
    delete '/routines/:id/delete' do
     if signed_in?
       @user = User.find_by(id: session[:user_id]) if session[:user_id]
       @routine = Routine.find_by_id(params[:id])
       # binding.pry
       if @routine && @routine.user == current_user
         @routine.delete
         redirect '/routines'
       end
     else
       redirect to '/signin'
     end
   end
  end 