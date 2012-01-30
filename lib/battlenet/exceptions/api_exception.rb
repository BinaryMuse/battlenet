class Battlenet
  class ApiException < Exception
    attr_accessor :response, :code, :reason

    def initialize(response)
      @response = response
      @code     = response.code
      @reason   = response['reason'] || nil
    end
  end
end
