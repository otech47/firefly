firefly aka miami bitstop hackathon
========

Getting Started with firefly
------------------------------

### Prerequisites

You're going to need:

 - **Ruby, version 2.1.5 or newer**
 - **Bundler** — If Ruby is already installed, but the `bundle` command doesn't work, just run `gem install bundler` in a terminal.
 - **MySQL** or **MariaDB** running localy

### Getting Set Up

1. Fork this repository on Github.
2. Clone *your forked repository* (not our original one) to your hard drive with `git clone https://github.com/YOURUSERNAME/firefly.git`
3. `cd firefly`
4. Install all dependencies: `bundle install`
5. Create database `rake db:create`
6. Migrate database `rake db:migrate`
7. Start the test server: `rails s`

You can now see firefly at <http://localhost:3000>. Whoa! That was fast!