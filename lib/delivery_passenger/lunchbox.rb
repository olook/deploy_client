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
      options[:file], options[:user], options[:update] = @schedule_file, 'root', true
      Whenever::CommandLine.execute(options)
    end

    def rollback
    end

    private

    def set_crondate_on_config_file(crondate)
      parse_raw_crondate(crondate)
      last_crondate = load_current_crondate
      last_crondate['crondate'] = parse_raw_crondate(crondate)
    end

    #def write_yaml(hash)
    #  File.open(@schedule_file, 'w') do |f|
    #    f.write(generate_yaml(hash))
    #  end
    #end

    #def generate_yaml(hash)
    #  method = hash.respond_to?(:ya2yaml) ? :ya2yaml : :to_yaml
    #  string = hash.deep_stringify_keys.send(method)
    #end

    def load_current_crondate
      crondate_file = File.dirname(__FILE__) + '/../../config/crondate.yml'
      YAML.load_file(crondate_file)
    end

    def parse_raw_crondate(crondate)
      crondate.strftime("%M %H %d %m")
    end
  end
end

