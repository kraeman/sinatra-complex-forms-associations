class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end

  post '/pets' do

    @pet = Pet.create(name: params["pet"]["name"])
    
    @pet.owner = Owner.find_by(id: params["pet"]["owner_id"])
    @pet.save
   
  
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
     ####### bug fix
   
    if !params["pet"].keys.include?("owner_ids")
      params[:pet]["owner"] = []
    end
    #######

    @pet = Pet.find_by(id: params["id"])

    @pet.update(name: params["pet_name"], owner_id: params["pet"]["owner_ids"].first)
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end

    redirect "pets/#{@pet.id}"
  end 
end