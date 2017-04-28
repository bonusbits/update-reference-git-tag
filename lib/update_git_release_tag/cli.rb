require 'update_git_release_tag'
require 'fileutils'
require 'git'
require 'logger'
require 'optparse'
require 'pp'

module UpdateGitReleaseTag
  class Cli
    # Parse Arguments/Options
    @options = Hash.new

    # Defaults
    @options['release'] = 'master'
    @options['tag'] = 'latest'
    # @options['project_root_path'] = File.expand_path File.dirname(__FILE__)
    @options['path'] = Dir.pwd
    @options['log_level'] = 'info'

    # ARGV << '-h' if ARGV.empty?

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

    def self.run
      # TODO: Logging
      # puts "OPTIONS: #{@options}"
      # Logger.log 'Running Git Command...'
      # tags = git.tags
      # Logger.log "Current Tags (#{tags})"
      git = Git.open(@options['path'], log: Logger.new(STDOUT))
      starting_point = git.branch
      git.pull
      git.delete_tag(@options['tag']) # TODO: Error Handling / Condition
      git.push('origin', "refs/tags/#{@options['tag']}", options: [force: true])
      git.checkout(@options['release'])
      git.add_tag(@options['tag'], options: [annotate: true, force: true, message: 'Refreshed latest Tag'])
      git.push('origin', "refs/tags/#{@options['tag']}", options: [force: true])
      git.checkout(starting_point)
    end
  end
end
