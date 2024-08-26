# window-arranger

`window-arranger` is a command-line tool for macOS that allows you to manage your application windows by list their positions and sizes to a YAML format, and configuring them using a YAML format. This tool is useful for developers or streamers who want to automate their window layouts.

## Requirements

    Ruby (>= 3)

## Installation

    $ gem install window_arranger

## Usage

### List Window Layout

You can list the current window layout to a YAML format with the following command:

    $ window-arranger list

### Update Window Layout

To update a window layout from a YAML format, use:

    $ cat windows.yml | window-arranger update


### Example YAML Format

Here’s an example of what the YAML string might look like:

    ---
    - appName: Arc # matches app named `Arc`
      position:
      - 0
      - 25
      size:
      - 1280
      - 1067
    - appName:
        regexp: ^Sla # matches app that has name starts widh `Sl` (eg. Slack)
      position:
      - 2560
      - 25
      size:
      - 1280
      - 1067



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/labocho/window_arranger.

