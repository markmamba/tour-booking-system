
class BaseError < StandardError
  attr_reader :details, :status_code

  def initialize(message:, details: nil, status_code: :internal_server_error)
    @details = details || {}
    @status_code = status_code
    super(message)
  end

  def http_status
    Rack::Utils::SYMBOL_TO_STATUS_CODE[status_code] || 500
  end

  def to_hash
    {
      error: {
        type: self.class.name.demodulize.underscore,
        message: message,
        details: details
      }
    }
  end
end
