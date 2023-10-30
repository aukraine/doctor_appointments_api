class BaseResource
  include Alba::Resource

  root_key :data, :data

  def self.formatted_time_attributes(*attrs)
    attrs.each do |attr|
      attribute attr do |object|
        time = object.public_send(attr)

        next unless time.is_a?(ActiveSupport::TimeWithZone)

        time.utc.iso8601
      end
    end
  end
end
