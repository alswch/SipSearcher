class NeighborhoodsController < ApplicationController
  before_action :set_neighborhood, only: [:show, :edit, :update, :destroy]

  # GET /neighborhoods
  # GET /neighborhoods.json
  def index
    puts "\n******** neighborhood_index ********"
    @neighborhoods = Neighborhood.all
  end

  # GET /neighborhoods/1
  # GET /neighborhoods/1.json
  def show
    puts "\n******** neighborhood_show ********"
  end

  # GET /neighborhoods/new
  def new
    puts "\n******** neighborhood_new ********"
    @neighborhood = Neighborhood.new
  end

  # GET /neighborhoods/1/edit
  def edit
    puts "\n******** neighborhood_edit ********"
  end

  # POST /neighborhoods
  # POST /neighborhoods.json
  def create
    puts "\n******** neighborhood_create ********"
    puts "*** neighborhood_params.inspect #{neighborhood_params.inspect} ***"
    @neighborhood = Neighborhood.new(neighborhood_params)

    respond_to do |format|
      if @neighborhood.save
        format.html { redirect_to "/neighborhoods", notice: 'Neighborhood was successfully created.' }
        format.json { render :show, status: :created, location: @neighborhood }
      else
        format.html { render :new }
        format.json { render json: @neighborhood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /neighborhoods/1
  # PATCH/PUT /neighborhoods/1.json
  def update
    puts "\n******** neighborhood_update ********"
    respond_to do |format|
      if @neighborhood.update(neighborhood_params)
        format.html { redirect_to @neighborhood, notice: 'Neighborhood was successfully updated.' }
        format.json { render :show, status: :ok, location: @neighborhood }
      else
        format.html { render :edit }
        format.json { render json: @neighborhood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /neighborhoods/1
  # DELETE /neighborhoods/1.json
  def destroy
    puts "\n******** neighborhood_delete ********"
    @neighborhood.destroy
    respond_to do |format|
      format.html { redirect_to neighborhoods_url, notice: 'Neighborhood was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_neighborhood
      puts "\n******** set_neighborhood ********"
      @neighborhood = Neighborhood.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def neighborhood_params
      puts "\n******** neighborhood_params ********"
      params.require(:neighborhood).permit(:neighborhood_name)
    end
end
