require 'update_git_release_tag'
require 'fileutils'
require 'git'
require 'logger'
require 'optparse'
require 'pp'

module UpdateGitReleaseTag
  class Cli < OptionParser
    # Defaults
    @options = Hash.new
    @options['release'] = 'master'
    @options['tag'] = 'latest'
    @options['path'] = Dir.pwd
    @options['log_level'] = 'info'

    options_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: ugrt -r master -t latest [OPTIONS]'
      opts.separator ''
      opts.separator 'Options:'
      opts.on('-r', '--release FULLNAME', 'Release Tag Name. Default is master  ') do |opt|
        @options['release'] = opt
      end
      opts.on('-t', '--tag', 'Tag to renew (Delete/Create). Default is latest') do |opt|
        @options['tag'] = opt
      end
      opts.on('-p', '--path', 'Root Path of Project. Default is Current Working Directory') do |opt|
        @options['path'] = opt
      end
      opts.on('-l', '--log-level', 'Log Output Level. Default is Info') do |opt|
        @options['log_level'] = opt
      end
      opts.on('-h', '--help', '(Flag) Show this message') do
        puts opts
        exit 0
      end
      opts.on('-v', '--version', '(Flag) Output Script Version') do
        puts "Update Git Release Tag v#{UpdateGitReleaseTag::VERSION}"
        exit 0
      end
    end
    options_parser.parse(ARGV)

    @logger = Logger.new(STDOUT)
    @logger.level = begin
                      Object.const_get("Logger::#{@options['log_level'].upcase}")
                    rescue
                      Logger::INFO
                    end
    # @logger.level = Logger::DEBUG
    @logger.level =
      case @options['log_level']
      when 'info'
        Logger::INFO
      when 'warn'
        Logger::WARN
      when 'debug'
        Logger::DEBUG
      when 'fatal'
        Logger::FATAL
      else
        Logger::INFO
      end
    @logger.progname = 'git commands'
    @logger.datetime_format = '%Y-%m-%d_%H:%M:%S'
    @logger.formatter = proc do |severity, datetime, progname, msg|
      "[#{datetime}] #{severity}: (#{progname.upcase}) #{msg}\n"
    end
    # e.g. "2005-09-22 08:51:08 +0900: hello world"
    # I, [2017-04-28 17:28:25#23575]  INFO -- git commands: Starting Git

    def self.run
      @logger.info 'Initializing...'
      # @logger.info('git_commands') { 'Initializing...' }
      git = Git.open(@options['path'], log: @logger)
      starting_point = git.branch
      git.pull
      tags = git.tags
      tags.each { |tag| git.delete_tag(@options['tag']) if tag.name.include?('latest') } unless tags.empty?
      git.push('origin', ":refs/tags/#{@options['tag']}", options: [force: true])
      git.checkout(@options['release'])
      git.add_tag(@options['tag'], options: [annotate: true, force: true, message: 'Refreshed Release Tag'])
      git.push('origin', 'master', options: [tags: true, force: true])
      git.checkout(starting_point)
    end
  end
end
