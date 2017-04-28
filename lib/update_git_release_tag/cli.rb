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
    @options['release_name'] = 'master'
    @options['tag_name'] = 'latest'
    # @options['project_root_path'] = File.expand_path File.dirname(__FILE__)
    @options['project_root_path'] = Dir.pwd
    @options['project_root_path'] = Dir.pwd

    ARGV << '-h' if ARGV.empty?

    options_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: ugrt -r master -t latest [OPTIONS]'
      opts.separator ''
      opts.separator 'Options:'
      opts.on('-r', '--release FULLNAME', 'Release Tag Name. Default is master  ') do |opt|
        @options['release_name'] = opt
      end
      opts.on('-t', '--tag', 'Tag to renew (Delete/Create). Default is latest') do |opt|
        @options['tag_name'] = opt
      end
      opts.on('-p', '--path', 'Root Path of Project. Default is Current Working Directory') do |opt|
        @options['project_root_path'] = opt
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

    # Meat and Potatoes
    def initialize_git
      Logger.log 'Initializing Git Library'
      @git = Git.open(@options['project_root_path'], log: Logger.new(STDOUT))
    end

    def git_commands
      Logger.log 'Running Git Command...'
      tags = @git.tags
      Logger.log "Current Tags (#{tags})"
      @git.pull
      @git.delete_tag('latest')
      @git.push('origin', 'HEAD:refs/tags/latest', options: [:force])
      @git.checkout('master')
      @git.add_tag('latest', options: [:a, :force, message: 'Refreshed latest Tag'])
      @git.push('origin', 'HEAD:refs/tags/latest', options: [:force])
      @git.checkout('master')
    end

    # Run List
    def run
      initialize_git
      git_commands
    end
  end
end
