class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :map_location, :map_all]
  skip_authorize_resource :only => [:index, :map_all]
  load_and_authorize_resource

  # GET /apartments
  # GET /apartments.json
  def index
    cookies.delete :search
    @apartments = Apartment.all
    @ability = Ability.new(current_user)
    if params[:search].present?
      @apartments_by_apt = Apartment.search(params[:search])
      @apartments_by_lister = Apartment.joins(:user).fuzzy_search(users: {email: params[:search]})
      @apartments = @apartments_by_apt | @apartments_by_lister
      cookies[:search] = params[:search]
    end
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
  end

  def map_location
    @apartment = Apartment.find(params[:apartment_id])
    @hash = Gmaps4rails.build_markers(@apartment) do |apartment, marker|
      marker.lat(apartment.latitude)
      marker.lng(apartment.longitude)
      marker.infowindow("<strong>" + apartment.address + "</strong>")
    end
    render json: @hash.to_json
  end

  def map_all
    if cookies[:search].present?
      @apartments_by_apt = Apartment.search(cookies[:search])
      @apartments_by_lister = Apartment.joins(:user).fuzzy_search(users: {email: cookies[:search]})
      @apartments = @apartments_by_apt | @apartments_by_lister
    else
      @apartments = Apartment.all
    end

    @hash = Gmaps4rails.build_markers(@apartments) do |apartment, marker|
      marker.lat(apartment.latitude)
      marker.lng(apartment.longitude)
      marker.infowindow("<strong>" + apartment.address + "</strong>")
    end
    render json: @hash.to_json
  end

  # GET /apartments/new
  def new
    @apartment = current_user.apartments.build
  end

  # GET /apartments/1/edit
  def edit
    # @apartment = Apartment.find(params[:id])
    redirect_to root_path, notice: 'Thou Shalt Not Pass' unless current_user == @apartment.user
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = current_user.apartments.build(apartment_params)

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    # @apartment = Apartment.find(params[:id])
    if current_user == @apartment.user
      @apartment.destroy
      respond_to do |format|
        format.html { redirect_to apartments_url, notice: 'Apartment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, notice: 'Thou Shalt Not Pass'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:street_one, :street_two, :city, :postal_code, :state, :country, :contact_name, :contact_phone, :contact_hours, :image)
    end
end
