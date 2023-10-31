class BaseQuery
  attr_reader :relation, :params

  def self.call(**args, &block)
    new(**args, &block).call
  end

  def call
    raise NotImplementedError, "#{self.class} doesn't implement #{__method__} method"
  end
end
