# UpdateGitReleaseTag
[![Circle CI](https://circleci.com/gh/bonusbits/update_git_release_tag/tree/master.svg?style=shield)](https://circleci.com/gh/bonusbits/update_git_release_tag/tree/master)
[![Join the chat at https://gitter.im/bonusbits](https://badges.gitter.im/bonusbits/bonusbits.svg)](https://gitter.im/bonusbits?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Description
Ruby Gem to quickly renew a git tag to a specific release locally and remotely. Such as, refreshing a tag named *latest* to the latest release.

## Installation

### Option 1 (rubygem.org) 
Install from a git URL source repository. No need to pull down the repo and build the gem!

1. Install from rubygem.org
    1. ```gem install update_git_release_tag --no-rdoc --no-ri```

### Option 2 (Use specific_install gem) 
Install from a git URL source repository. No need to pull down the repo and build the gem!

1. Install '''specific_install''' gem
    1. ```gem install specific_install --no-rdoc --no-ri```
2. Install gem from git source
    1. ```gem specific_install https://github.com/bonusbits/update_git_release_tag.git```

### Option 2 (Bundler/GemFile)
1. Install bundler gem if missing
    1. ```gem install bundler --no-rdoc --no-ri```
2. Add the gem to your GemFile
    1. ```vim path/to/project/GemFile```
    2. ```gem 'GEMNAME', :github => 'bonusbits/update_git_release_tag'```
    <br>**OR**
    1. ```gem 'GEMNAME', :git => 'git://github.com/bonusbits/update_git_release_tag.git'```
3. Run Bundler from the project folder where the GemFile resides.
    1. ```bundle install```

### Option 3 (Rake Task)
1. Clone the repository
    1. ```git clone https://github.com/bonusbits/update_git_release_tag.git```
2. Change directories to the root of the cloned repository    
3. Build Gem from source
    1. ```rake install:local```

### Option 4 (Clone/Build)
1. Clone the repository
    1. ```git clone https://github.com/bonusbits/update_git_release_tag.git```
2. Change directories to the root of the cloned repository    
3. Build Gem from source
    1. ```gem build update_git_release_tag.gemspec```
4. Install the gem
    1. ```gem install -l /path/to/gem/file/update_git_release_tag.gem```

## Usage

```
Usage: ugrt -r master -t latest [OPTIONS]

Options:
    -r, --release FULLNAME           Release Tag Name. Default is master
    -t, --tag                        Tag to renew (Delete/Create). Default is latest
    -p, --path                       Root Path of Project. Default is Current Working Directory
    -l, --log-level                  Log Output Level. Default is Info
    -h, --help                       (Flag) Show this message
    -v, --version                    (Flag) Output Script Version
```

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/bonusbits/update_git_release_tag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
