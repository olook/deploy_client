module DeliveryPassenger
  class Lunchbox
    attr_reader :schedule_file, :date

    def initialize
      @schedule_file = File.dirname(__FILE__) + '/../../config/schedule.rb'
    end

    def dispatcher(type, crondate)
      case type
        when 'deploy'
          set_crondate_on_config_file(crondate)
          deploy
        when 'rollback'
          rollback
      end
    end

    def deploy
      options = {}
      options[:file], options[:update] = @schedule_file, true
      Whenever::CommandLine.execute(options)
    end

    def rollback
    end

    private

    def set_crondate_on_config_file(crondate)
      current_crondate = load_current_crondate
      current_crondate['crondate'] = parse_raw_crondate(crondate)
      write_yaml(current_crondate)
    end

    def load_current_crondate
      crondate_file = File.dirname(__FILE__) + '/../../config/crondate.yml'
      YAML.load_file(crondate_file)
    end

    def parse_raw_crondate(crondate)
      crondate.strftime("%M %H %d %m")
    end

    def write_yaml(hash)
      File.open(@schedule_file, 'w') do |f|
        f.write(hash.to_yaml)
      end
    end
  end
end

