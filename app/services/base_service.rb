class BaseService
  def call
    raise NotImplementedError
  end

  private

  def success(value = nil)
    { success: true, value: value }
  end

  def failure(error = nil)
    { success: false, error: error }
  end
end
