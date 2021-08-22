# frozen_string_literal: true

##
class ReservationService
  def initialize(payload)
    @payload = payload

    file = File.open('app/assets/api/reservation_data_mapping.json')
    @data_key_mappings = JSON.load(file).deep_symbolize_keys

    @reservation_params = Reservation.new.attributes.symbolize_keys.except(
      :id, :created_at, :updated_at
    )
  end

  def parse_data(_parent, data)
    data.each do |key, value|
      if value.is_a?(Hash)
        parse_data(key, value)
      else
        @data_key_mappings.each do |mapping_key, mapping_val|
          if mapping_val.include?(key.to_s)
            @reservation_params[mapping_key] = value
            break
          end
        end
      end
    end
  end

  def process_payload
    parse_data(nil, @payload)
  end

  def build_record
    guest = Guest.find(@reservation_params[:guest_id])
    reservation = Reservation.new(@reservation_params)
    reservation.guest = guest
    reservation
  end

  def update_params
    @reservation_params
  end
end
