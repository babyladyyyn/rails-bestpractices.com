Rails Best Practices Website
----------------------------

[![Build Status](https://secure.travis-ci.org/railsbp/rails-bestpractices.com.png)](http://travis-ci.org/railsbp/rails-bestpractices.com)
[![Coverage Status](https://coveralls.io/repos/railsbp/rails-bestpractices.com/badge.png?branch=master)](https://coveralls.io/r/railsbp/rails-bestpractices.com?branch=master)
[![Dependency Status](https://gemnasium.com/railsbp/rails-bestpractices.com.png)](https://gemnasium.com/railsbp/rails-bestpractices.com)
[![Security Status](http://rails-brakeman.com/railsbp/rails-bestpractices.com.png)](http://rails-brakeman.com/railsbp/rails-bestpractices.com)

[![Click here to lend your support to: rails-bestpractices.com and make a donation at www.pledgie.com !](https://pledgie.com/campaigns/12057.png?skin_name=chrome)](https://pledgie.
com/campaigns/12057)

rails-bestpractices.com is aimed to share everyone's rails best practices.

Any questions and suggestions are welcome, please contact me: flyerhzm@rails-bestpractices.com.

rails_best_practices gem
-----------------------

<https://github.com/railsbp/rails_best_practices>

Setup
-----

1. git clone repository

2. copy all config/*.yml.example to config/*.yml, and change to what you want

3. setup database

    rake db:create && rake db:migrate && rake db:seed

4. generate css sprite

    rake css_sprite:build

5. start server

    rails s
