module DeliveryPassenger
  class Lunchbox
    attr_reader :schedule_file, :date

    def initialize
      @schedule_file = File.dirname(__FILE__) + '/../../config/schedule.rb'
      @crondate_file = File.dirname(__FILE__) + '/../../config/crondate.yml'
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
      options[:file], options[:update], options[:user] = @schedule_file, true, 'root'
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
      YAML.load_file(@crondate_file)
    end

    def parse_raw_crondate(crondate)
      crondate.strftime("%M %H %d %m *")
    end

    def write_yaml(hash)
      File.open(@crondate_file, 'w') do |f|
        f.write(hash.to_yaml)
      end
    end
  end
end

