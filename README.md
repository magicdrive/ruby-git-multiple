[![Build Status](https://travis-ci.org/magicdrive/ruby-git-multiple.svg?branch=master)](https://travis-ci.org/magicdrive/ruby-git-multiple)
[![Build Status](https://drone.io/github.com/magicdrive/ruby-git-multiple/status.png)](https://drone.io/github.com/magicdrive/ruby-git-multiple/latest)

# Git::Multiple

Run the git command in parallel much to multiple git repositories.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git-multiple'
```

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install git-multiple

## Usage
  
  
* `help`: show help

```
$ git multiple help
```

* `--exec|-e` (required): Define the command to be executed.

```
$ git multiple --exec 'pull --rebase'
```
* `--dirname|-d`: Specification of directories to search.(default `pwd`)

```
$ git multiple --exec status --dirname /tmp
```

* `--jobs|-j`: Number of jobs to be executed in parallel.

```
$ git multiple --exec status --jobs 4
```
* `--maxdepth|-m`: Deepest hierarchy of the directory to search. (default `1`)

```
$ git multiple --exec status --maxdepth 10
```

* `--no-color|-c`: is not carried out by coloring ANSI color.

```
$ git multiple --exec status --no-color
```

####Of course, these options can be used in combination.

```
$ git multiple --exec 'pull  --rebase' \
						   --no-color  \
						   --maxdepth 5 \
						   --jobs 8
```

####enjoy!

## Contributing

1. Fork it ( https://github.com/magicdrive/ruby-git-multiple/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
