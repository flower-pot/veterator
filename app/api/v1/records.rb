module V1
  class Records < Grape::API
    rescue_from ActiveRecord::RecordNotFound do
      rack_response({ message: '404 Not Found' }.to_json, 404)
    end

    rescue_from CanCan::AccessDenied do
      rack_response({ message: '403 Access Denied' }.to_json, 403)
    end

    format :json
    content_type :json, 'application/json'

    namespace :sensors do
      helpers do
        def authenticate!
          unauthenticated! unless current_user
        end

        def unauthenticated!
          error!({ message: '401 Unauthenticated' }, 401)
        end

        def unprocessable!(entity)
          error!({ message: entity.errors.full_messages }, 422)
        end

        def current_user
          return unless authentication_token
          User.find_by_raw_token authentication_token
        end

        def authentication_token
          env['HTTP_AUTHORIZATION']
        end

        def authorize!(*args)
          ::Ability.new(current_user).authorize!(*args)
        end
      end

      # Create a new record for a sensor
      post '/:id/records' do
        authenticate!
        sensor = Sensor.find params[:id]
        authorize! :update, sensor
        record = sensor.records.new value: params[:value]
        unprocessable!(record) unless record.valid?
        record.save
        AggregateRecordsJob.perform_later
        { value: record.value, sensor_id: sensor.id }
      end
    end
  end
end

