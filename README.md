Rails Best Practices Website
----------------------------

The rails-bestpractices.com is in progress. It is aimed to get the rails best practices and share your rails best practices.

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
