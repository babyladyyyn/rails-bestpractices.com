Rails Best Practices Website
----------------------------

[![Build Status](https://secure.travis-ci.org/railsbp/rails-bestpractices.com.png)](http://travis-ci.org/railsbp/rails-bestpractices.com)

[![Click here to lend your support to: rails-bestpractices.com and make a donation at www.pledgie.com !](https://www.pledgie.com/campaigns/12057.png?skin_name=chrome)](http://www.pledgie.com/campaigns/12057)

rails-bestpractices.com is aimed to share everyone's rails best practices.

If you have interests to join the development, please contact me: flyerhzm@gmail.com.

rails_best_practices gem
-----------------------

<https://github.com/flyerhzm/rails_best_practices>

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
