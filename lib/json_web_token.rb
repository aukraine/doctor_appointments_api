class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256').first.with_indifferent_access
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    nil
  end
end
