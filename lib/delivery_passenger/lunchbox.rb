module DeliveryPassenger
  class Lunchbox
    attr_reader :schedule_file

    def initialize
      @schedule_file = File.dirname(__FILE__) + '/../../config/schedule.rb'
    end

    def deploy
      options          = {}
      options[:file]   = @schedule_file
      options[:update] = true
      Whenever::CommandLine.execute(options)
    end

    def rollback
    end
  end
end

