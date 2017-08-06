class BarsController < ApplicationController
  before_action :set_bar, only: [:show, :edit, :update, :destroy]
  include Google_places

  # GET /bars
  # GET /bars.json
  def index
    puts "\n******** bars_index ********"
    @bars = Bar.all
  end

  # ==== Dynamic Google Map API Search ====
  # GET /find_bar
  def find_bar
      gon.js_presence = true
      @neighborhoods = Neighborhood.all
      @tags = Tag.all
      @bar = Bar.new
      puts "\n******* find_bar *******"
      puts "find_bar_params.inspect: #{find_bar_params.inspect}"
      permitted_params = find_bar_params
      puts "== permitted_params.inspect: #{permitted_params.inspect}"

      # == list of local bars via google places
      search_bars = find_local_bars(permitted_params[:neighborhood])
      @neighborhood = Neighborhood.where(neighborhood_name: permitted_params[:neighborhood]).first
      puts "=====||| @neighborhood.id: #{@neighborhood.id} |||====="

      puts "+++ search_bars.inspect #{search_bars.inspect}"
      json_data = Google_places.places_api_response(search_bars)
      @place_data_array = json_data['results']

      # == find bar from submitted barname value
      @which_bar = get_target_bar(@place_data_array, permitted_params[:bar_name])
      puts "***+++ @which_bar.inspect #{@which_bar.inspect} +++***"

      # == search array for bar data
      if @which_bar
          puts "\n**++ Bar Found ++**"
          @place_data_array.each do |bar|
              if bar['name'] == @which_bar['name']
                  lat = @which_bar['geometry']['location']['lat']
                  lng = @which_bar['geometry']['location']['lng']
                  address = @which_bar['vicinity']
                  @which_bar_info = { name:@which_bar['name'], neighborhood: permitted_params[:neighborhood], address:address, lat:lat, lng:lng}
              end
          end
      else
          puts "\n**++ Bar Not Found ++**"
          @which_bar_info = { name:"bar not found", neighborhood: permitted_params[:neighborhood], address:nil, lat:nil, lng:nil }
      end

      # == map data source via google maps
      puts "*++ @which_bar_info.inspect: #{@which_bar_info.inspect} ++*"
      render "local_bars"
  end

  # GET /find_local_bars
  def find_local_bars(neighborhood)
      puts "\n******* find_local_bars *******"

      # == search for bar locations within 500' of neighborhood
      location = get_lat_lon(neighborhood)
      radius = "500"
      types = "bar"
      key = GOOGLE_PLACES_KEY

      search_bars = "location=" + location
      search_bars += "&radius=" + radius
      search_bars += "&types=" + types
      search_bars += "&key=" + key

      puts "+=+ search_bars.inspect #{search_bars.inspect}+=+"

      return search_bars
  end

  # GET /get_lat_lon
  def get_lat_lon(neighborhood)
    puts "\n******* get_lat_lon *******"
    if neighborhood == "Downtown"
        loc = { latitude: 38.904706, longitude: -77.034715}
    elsif neighborhood == "U-Street Corridor"
        loc = { latitude: 38.916965, longitude: -77.029642}
    elsif neighborhood == "Bloomingdale"
        loc = { latitude: 38.915730, longitude: -77.012186}
    elsif neighborhood == "Columbia Heights"
        loc = { latitude: 38.930178, longitude: -77.032753}
    elsif neighborhood == "Petworth"
        loc = { latitude: 38.937189, longitude: -77.021885}
    elsif neighborhood == "11th St"
        loc = { latitude: 38.931806, longitude: -77.028258}
    else
        loc = { latitude: 38.904706, longitude: -77.034715}
    end
    return "#{loc[:latitude]},#{loc[:longitude]}"
  end

  # GET /get_target_bar
  def get_target_bar(places_array, bar_name)
      puts "\n******* get_target_bar *******"
      puts "places_array.inspect #{places_array.inspect}"
      puts "bar_name.inspect #{bar_name.inspect}"

      found_bar = nil
      places_array.each_with_index do |place, index|
          if place["name"].include? bar_name
              puts "place['name'] includes #{bar_name}"
              found_bar = place
              puts "== found_bar.inspect #{found_bar.inspect} =="
              return found_bar
          end
      end
      return nil
  end

  # GET /local_bars_json
  def local_bars_json
    puts "\n******* local_bars_json *******"
    puts "params: #{params.inspect}"
    search_bars = find_local_bars(params[:neighborhood])
    json_data = Google_places.places_api_response(search_bars)
    @place_data_array = json_data['results']
    puts "@place_data_array[0]: #{@place_data_array[0].inspect}"
    respond_to do |format|
      format.json {
         render json: {:place_data_array => @place_data_array}
      }
    end
  end

  # GET /make_local_map
  def make_local_map(neighborhood)
      puts "\n******* make_local_map *******"

      # == search for bar locations within 500' of target
      location = get_lat_lon(neighborhood)

      key = GOOGLE_MAPS_KEY
      remote_url = "https://www.google.com/maps/embed/v1/place"
      remote_url += "?key=" + key
      remote_url += "&q=" + location
      puts "remote_url: #{remote_url.inspect}"
      return remote_url
  end

  # ===== Static Bar Profile Map =====
  # GET /create_bar_map
  def create_bar_map(latitude, longitude)
      puts "\n******* create_bar_map *******"

      key = GOOGLE_MAPS_KEY
      remote_url = "https://www.google.com/maps/embed/v1/place"
      remote_url += "?key=" + key
      remote_url += "&q=" + latitude.to_s + "," + longitude.to_s
      puts "remote_url: #{remote_url.inspect}"
      return remote_url
  end

  # ==== Create Bar Method ====
  # GET /bars/1
  # GET /bars/1.json
  def show
    puts "\n******** bar_show ********"
    puts "*** params.inspect: #{params.inspect} ***"
    @user = User.find(current_user.id)
    @reports = @bar.reports
    puts "*** @reports.inspect: #{@reports.inspect} ***"
    @report = Report.new
    @tags = @bar.tags
    puts "*** @tags.inspect, #{@tags.inspect} ***"
    session[:bar_id] = @bar.id
    beer_accumulator = 0
    wine_accumulator = 0
    cocktails_accumulator = 0
    rating_accumulator = 0
    @reports.each do |report|
        beer_accumulator += report.beer_price
        wine_accumulator += report.wine_price
        cocktails_accumulator += report.cocktails_price
        rating_accumulator += report.rating
    end
    if @reports.length > 0
        @beer_avg = beer_accumulator / @reports.length
        @wine_avg = wine_accumulator / @reports.length
        @cocktails_avg = cocktails_accumulator /
        @rating_avg = rating_accumulator / @reports.length
    else
        @beer_avg = 0
        @wine_avg = 0
        @cocktails_avg = 0
        @rating_avg = 0
    end
    puts "***== @bar.inspect, #{@bar.inspect} ==***"
    puts "@bar.latitude, #{@bar.latitude}"
    puts "@bar.longitude, #{@bar.longitude}"

    @src = create_bar_map(@bar.latitude, @bar.longitude)

    # puts "@beer_avg: #{@beer_avg}"
    # puts "@wine_avg: #{@wine_avg}"
    # puts "@cocktails_avg: #{@cocktails_avg}"
    # puts "@rating_avg: #{@rating_avg}"
    # puts "*** session[:bar_id].inspect: #{session[:bar_id].inspect} ***"
    # puts "***== @user.inspect, #{@user.inspect} ==***"
    #
  end

  # ==== Bar CRUD Section ====
  # GET /bars/new
  def new
    puts "\n******** bar_new ********"
    @neighborhoods = Neighborhood.all
    @bar = Bar.new
    @tags = Tag.all
    puts "*** @neighborhood.inspect: #{@neighborhood.inspect} ***"
  end

  # GET /bars/1/edit
  def edit
    puts "\n******** bar_edit ********"
  end

  # POST /bars
  # POST /bars.json
  def create
    puts "\n******** bar_create ********"
    @bar = Bar.new(bar_params)

    respond_to do |format|
      if @bar.save
        # @bar.tags << Tag.find(params[:tag_id])
        @new_bar = Bar.order("created_at").last
        puts "+++ @new_bar: #{@new_bar} +++"
        format.html { redirect_to bar_path(@new_bar.id)}
        format.json { render :show, status: :created, location: @bar }
      else
        puts '+++ Bar Creation Failed +++'
        @neighborhoods = Neighborhood.all
        format.html { render :new, notice: 'Bar creation failed.'}
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bars/1
  # PATCH/PUT /bars/1.json
  def update
    respond_to do |format|
      if @bar.update(bar_params)
        format.html { redirect_to @bar, notice: 'Bar was successfully updated.' }
        format.json { render :show, status: :ok, location: @bar }
      else
        format.html { render :edit }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bars/1
  # DELETE /bars/1.json
  def destroy
    puts "\n******** bar_delete ********"
    @bar.destroy
    respond_to do |format|
      format.html { redirect_to bars_url, notice: 'Bar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bar
      puts "\n******** set_bar ********"
      @bar = Bar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bar_params
      puts "\n******** bar_params ********"
      params.require(:bar).permit(:neighborhood_id, :name, :address, :latitude, :longitude, :phone_number, :start_day, :end_day, :start_hour, :end_hour, :beer_price, :wine_price, :cocktails_price)
    end

    def find_bar_params
      puts "\n******** find_bar_params ********"
      params.permit(:neighborhood, :bar_name)
    end
end
