# RogerVisualRegression

This gem exists of two commands: a generator and a test. The generator creates for every .html(.erb) files in the project a spec file. This spec files is very simple, it visits the page and it should match the expectation:

```ruby
describe "Base test for index.html.erb", :type => :feature, :js => true do
  before(:each) do
    visit "http://localhost:9000/index.html"
    sleep 2
  end
  it { expect(page).to match_expectation } 
end    
```

When there's no expectation, it will save screenshots to a temporary folder. You should manually move these screenshots next to the specs. When running te test again, it will match against these screenshots.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'roger_visual_regression'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roger_visual_regression

## Usage

This gem exists of two commands: a generator and a test-command.

### Generating base specs

    $ bundle exec roger generate rogervisualregression::

### Test it!

First add the following block to you Mockupfile

```ruby
mockup.test do |test|
  test.use :visual_regression, {spec_path: 'spec/'}
end    
```

Then run the command on the commandline:
    
    $ bundle exec roger test

When this is the first time you run this command, the screenshots can be found at: `tmp/spec/expectation/**/test.png`. Copy the expectation folder to your spec path:

    $ mv tmp/spec/expectation spec/expectation && find ./spec/expectation -iname "test.png" -exec bash -c 'mv $0 ${0/test.png/expected.png}' {} \;

Then u can checkout another commit and run the tests again (make sure the expected.png still exists), then it will tell you if it spot any differences!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/roger_visual_regression/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
