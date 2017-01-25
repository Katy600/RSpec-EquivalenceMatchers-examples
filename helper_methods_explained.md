# Setting up RSpec

First initialize your project using rspec --init

This will
1. Create a file for us at the root of our project called .rspec.
2. Create a new file in our Spec Directory called spec_helper.rb.

### What does --require spec_helper mean?
Every time we run any specs with RSpec, it will automatically require our spec_helper file.
Before this you would have to require it inside every single spec file.

### What do we put in our spec_helper?
###### 1. Is the configuration for our spec itself.

RSpec.configure do |config|

##### 2. Helper methods( setting up old or new syntax)

RSpec.configure do |expectations|

  config.expect_with: rspec do |c|
  expectations.syntax = [:should, :expect] (This is the old syntax)

  expectations.syntax = :expect (This is the new syntax)

  end

###### 3. Make sure you have a way to know what your root application is.
APP_ROOT = File.expand_path('../..', _FILE_)

The parent directory of the directory of the file.
/Users/kevinskoglund/Desktop/car_project.
So now that path is defined, it is a full, absolute path, you can use APP_ROOT inside you application.
If you want to locate a file that's somewhere, you can do that relative to your project directory.

##### 4. Put common methods inside.
Put common methods that you wanna make available for use throughout your test suite.
If there's a method that's just used by one spec or by a couple of specs, it can be put
in a separate file that only gets loaded some of the time.
