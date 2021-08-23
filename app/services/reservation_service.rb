# frozen_string_literal: true

##
# Main Service used for accepting dynamic Reservation payload
# The json file is what is keeping track of which possible keys
# for a corresponding field.

# (app/assets/api/reservation_data_mapping.json)

# In the event a third payload is introduced, we could just simply
# add the keys to the json file which corresponds to the db field.
# rubocop:disable Security/JSONLoad
class ReservationService
  def initialize(payload)
    @payload = payload

    file = File.open('app/assets/api/reservation_data_mapping.json')
    @data_key_mappings = JSON.load(file).deep_symbolize_keys

    @data_params = {}
  end

  def parse_data(_parent, data)
    data.each do |key, value|
      if value.is_a?(Hash)
        parse_data(key, value)
      else
        @data_key_mappings.each do |mapping_key, mapping_val|
          next unless mapping_val.include?(key.to_s)

          case mapping_key
          when :phone
            if value.is_a?(Array)
              @data_params[mapping_key] = value
            else
              @data_params[mapping_key] = []
              @data_params[mapping_key] << value
            end
          else
            @data_params[mapping_key] = value
            break
          end
          break
        end
      end
    end

    @guest_params = @data_params.select do |key, _value|
      Guest.new.attributes.symbolize_keys.except(
        :id, :created_at, :updated_at
      ).key? key
    end

    @reservation_params = @data_params.select do |key, _value|
      Reservation.new.attributes.symbolize_keys.except(
        :id, :created_at, :updated_at
      ).key? key
    end
  end

  def process_payload
    parse_data(nil, @payload)
  end

  def build_guest_record
    @guest = Guest.find_by(id: @data_params[:guest_id])
    unless @guest.nil?
      @guest.update(@guest_params)
      return @guest
    end
    @guest = Guest.new(@guest_params)
    @guest
  end

  def build_reservation_record
    @reservation = Reservation.find_by(guest_id: @reservation_params[:guest_id])
    unless @reservation.nil?
      @reservation.update(@reservation_params)
      return @reservation
    end
    @reservation = Reservation.new(@reservation_params)
    @reservation.guest = @guest
    @reservation
  end

  def update_params
    @data_params
  end
end
# rubocop:enable Security/JSONLoad
