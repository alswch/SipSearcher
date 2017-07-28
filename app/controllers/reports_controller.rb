class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    puts "\n******** reports_index ********"
    @reports = Report.all
    @user = User.all
    @bars = Bar.all
    puts "******** @user.inspect: #{@user.inspect} ********"
    puts "******** @bar.inspect: #{@bar.inspect} ********"
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    puts "\n******** reports_show ********"
    @report = Report.all
  end

  # GET /reports/new
  def new
    puts "\n******** reports_new ********"
    @user = User.find(current_user.id)
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    puts "\n******** reports_edit ********"
  end

  # POST /reports
  # POST /reports.json
  def create
     puts "\n******** reports_create ********"
     puts "report_params: #{report_params.inspect}"

     new_params = report_params
     new_params[:user_id] = current_user.id
     puts "new_params: #{new_params.inspect}"

    @report = Report.new(new_params)
     puts "@report: #{@report}"

    respond_to do |format|
       if @report.save
           puts "==++ create report SAVED ++=="
           @report = Report.order("created_at").last
           puts "@report[:id]: #{@report[:id]}"
           puts "session[:bar_id]: #{session[:bar_id].inspect}"
           @bar_report = BarReport.create(bar_id:session[:bar_id], report_id:@report[:id] )
           format.html { redirect_to bar_path(session[:bar_id]), notice: 'Report was successfully created.' }
           format.json { render :show, status: :created, location: @report }
       else
           puts "==++ create report FAILED ++=="
         # format.html { render :new }
         format.html { redirect_to '/', notice: 'Report was not created.' }
         format.json { render json: @report.errors, status: :unprocessable_entity }
       end
     end
   end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
      puts "\n******** reports_update ********"
      new_params = report_params
      new_params[:user_id] = current_user.id
      respond_to do |format|
        if @report.update(new_params)
          format.html { redirect_to @report, notice: 'Report was successfully updated.' }
          format.json { render :show, status: :ok, location: @report }
        else
          format.html { render :edit }
          format.json { render json: @report.errors, status: :unprocessable_entity }
        end
      end
   end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    puts "\n******** reports_delete ********"
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      puts "\n******** set_reports ********"
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      puts "\n******** reports_params ********"
      params.require(:report).permit(:user_id, :beer_price, :wine_price, :cocktails_price, :rating, :comment )
    end
end
