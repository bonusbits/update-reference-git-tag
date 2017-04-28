require 'update_git_release_tag/version'

module UpdateGitReleaseTag
  # !/usr/bin/env ruby

  require 'fileutils'
  require 'git'
  require 'logger'
  require 'optparse'
  require 'pp'

  @script_version = '1.1.0'

  # Parse Arguments/Options
  @options = Hash.new

  # Defaults
  @options['release_tag_name'] = 'master'
  @options['new_tag_name'] = 'latest'
  # @options['project_root_path'] = File.expand_path File.dirname(__FILE__)
  @options['project_root_path'] = Dir.pwd

  ARGV << '-h' if ARGV.empty?

  options_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: bdi.rb -c examples/chef.yml [OPTIONS]'
    opts.separator ''
    opts.separator 'Options:'
    opts.on('-r', '--ref-release FULLNAME', 'Release Tag Name. Default is master  ') do |opt|
      @options['release_tag_name'] = opt
    end
    opts.on('-n', '--new-tag', 'Tag to renew (Delete/Create). Default is latest') do |opt|
      @options['new_tag_name'] = opt
    end
    opts.on('-p', '--path', 'Root Path of Project. Default is Current Working Directory') do |opt|
      @options['project_root_path'] = opt
    end
    opts.on('-h', '--help', '(Flag) Show this message') do
      puts opts
      exit 0
    end
    opts.on('-v', '--version', '(Flag) Output Script Version') do
      puts "Update Reference Git Tag v#{@script_version}"
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
  def run_list
    initialize_git
    git_commands
  end

  run_list
end
