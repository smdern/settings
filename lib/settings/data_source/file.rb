class Settings
  module DataSource
    class File
      dependency :logger, Telemetry::Logger

      attr_reader :source

      def initialize(source)
        @source = source
      end

      def self.build(source=nil)
        logger = Telemetry::Logger.get self

        logger.trace "Building"

        new(source).tap do |instance|
          Telemetry::Logger.configure instance
          logger.debug "Built"
        end
      end

      def canonical
        return default_filepath if source.nil?

        dirpath = nil
        filepath = nil

        unless file?(source)
          dirpath = Pathname.new(source)
          filepath = Pathname.new(Defaults.filename)
        end

        unless dir?(source)
          dirpath = Pathname.new(Directory::Defaults.pathname)
          filepath = Pathname.new(source)
        end

        (dirpath + filepath).to_s
      end

      def default_filepath
        dirpath = Pathname.new(Directory::Defaults.pathname)
        filepath = Pathname.new(Defaults.filename)

        (dirpath + filepath).to_s
      end

      def file?(filepath)
        ::File.extname(filepath) != ""
      end

      def dir?(dirpath)
        ::File.dirname(dirpath) != "."
      end

      module Defaults
        def self.logger
          @logger ||= ::Telemetry::Logger.get self
        end

        def self.filename
          default_file = 'settings.json' # .tap
          logger.debug "Using the default settings file name (#{default_file})"
          default_file
        end
      end

      module Directory
        module Defaults
          def self.pathname
            logger = ::Telemetry::Logger.get self
            default_dir = Dir.pwd
            logger.debug "Using the working directory default settings directory (#{default_dir})"
            default_dir
          end
        end
      end
    end
  end
end
