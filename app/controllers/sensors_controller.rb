class SensorsController < ApplicationController
  include DateFilter
  layout Proc.new { |controller| (action_name == 'index' || action_name == 'new') ? 'application' : 'sensor' }
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: :index
  authorize_resource

  # GET /sensors
  # GET /sensors.json
  def index
    return redirect_to '/users/sign_in' unless user_signed_in?
    @sensors = current_user.sensors

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sensors }
    end
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    set_filter_dates
    set_granularity
    @records = @sensor.records.where(created_at: @from..@to)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sensor }
    end
  end

  # GET /sensors/new
  def new
    @sensor = Sensor.new
  end

  # GET /sensors/1/edit
  def edit
  end

  # POST /sensors
  # POST /sensors.json
  def create
    @sensor = Sensor.new(sensor_params)

    respond_to do |format|
      if @sensor.save
        format.html { redirect_to @sensor, notice: 'Sensor was successfully created.' }
        format.json { render json: @sensor, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to @sensor, notice: 'Sensor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @sensor.destroy
    respond_to do |format|
      format.html { redirect_to sensors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor).permit(:title, :description, :chart_type, sensor_accesses_attributes: [:id, :user_id, :access_level, :_destroy])
    end
end
