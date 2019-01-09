[![Build Status](https://travis-ci.org/kontena/clamp-completer.svg?branch=master)](https://travis-ci.org/kontena/clamp-completer)
[![Gem Version](https://badge.fury.io/rb/clamp-completer.svg)](https://badge.fury.io/rb/clamp-completer)

# Clamp::Completer

Automatically generate shell auto-completion scripts for Ruby command-line tools built using the [clamp](https://github.com/mdub/clamp) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clamp-completer'
```

Or install it yourself as:

```
$ gem install clamp-completer
```

## Usage

Require the `clamp/completer` and in your application's root command, add a subcommand:

```ruby
require 'clamp/completer'

Clamp do
  subcommand "complete", "shell autocompletions", Clamp::Completer.new(self)
end
```

This will add a `complete` subcommand:

```
$ your_app complete zsh
$ your_app complete bash
```

You can redirect the output to a static file or load the output directly into the running environment:

```
# zsh / bash:
$ source <(your_app complete)
# or for the macOs preinstalled bash version:
$ source /dev/stdin <<<"$(your_app complete bash)"
```

### Customizing completions

Currently, subcommand completions and flag-type options defined through `option '--debug', :flag, 'enable debug'` should work correctly out-of-the-box. For options that take parameters,
such as file paths or a predefined set of words, you can define methods on your command classes that will be used to determine how the values should be completed:

```ruby
Clamp do
  option '--config', 'YAML_FILE', "configuration YAML file path"

  def complete_yaml_file # name derived from the YAML_FILE argument description
    { glob: '*.yml' }
  end
end
```

```ruby
Clamp do
  option '--role', 'ROLE_NAME', "node role"

  def complete_role # name derived from the attribute name
    "master worker" # will add "master" and "worker" as completion responses when you do: your_app --role <tab>
  end
end
```

#### Completion method response types

##### String

A space separated string of possible values for the option

##### Symbol

Currently known symbols:

* `:dirs` will complete directory names
* `:files` will complete file names
* `:hosts` will complete known host names

##### Hash

Much like the Symbols, but returned in Hash format to enable passing options:

* `{ glob: '*.yml' }` will complete files endinging with `.yml`
* `{ command: 'cut -d':' -f1 /etc/passwd' }` will run a command to get completion candidates, in this case the usernames from `/etc/password`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/clamp-completer.
