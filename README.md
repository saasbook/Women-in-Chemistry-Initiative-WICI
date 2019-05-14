# Women In Chemistry Initiative
[![Maintainability](https://api.codeclimate.com/v1/badges/d46360549fe56fe328d4/maintainability)](https://codeclimate.com/github/walkerspence/Women-in-Chemistry-Initiative-WICI/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d46360549fe56fe328d4/test_coverage)](https://codeclimate.com/github/walkerspence/Women-in-Chemistry-Initiative-WICI/test_coverage)
[![Build Status](https://travis-ci.org/walkerspence/Women-in-Chemistry-Initiative-WICI.svg?branch=master)](https://travis-ci.org/walkerspence/Women-in-Chemistry-Initiative-WICI)

http://women-in-chemistry-initiative.herokuapp.com





To run this project locally:\
  Decrypt `application.yml` if you have access to the key, or add your own API keys to `secrets.yml`. Then run
  ```bash
  bundle install --without production
  ```
  After the gems have installed, set up the database by running
  ```bash
  rake db:setup
  ```
  Next install ImageMagik. If using homebrew, run
  ```bash
  brew install imagemagick
  ```
  On Linux
  ```bash
  sudo apt-get install imagemagick
  ```
  After that, install the redis server with
  ```bash
  brew install redis
  ```
  If using Linux, instead run
  ```bash
  sudo apt-get install redis
  ```
  Once Redis has been installed, run:
  ```bash
  redis-server
  ```
  Finally, in another terminal run
  ```bash
  rails s
  ```
  and open http://localhost:3000/ in your browser.


To setup an admin account:
 - Go to /admins/sign_up and make a new account.
 - Then, go to /admins/sign_in and sign in with the temporary admin.
  ```
  Email: tempadmin@wici.com
  Password: WICIWebsite
  ```
 - Go to the accounts page and approve your admin account.
 - Click "Sign Out".
 - Then go to /admins/sign_in and log in with your new account.
 - Finally, go to the accounts page and delete the tempadmin@wici.com account.
 - Admins accounts can add/edit events and tasks, approve/delete volunteers and admins, delete guests, and more. They can also change the leaders displayed on the about page.

Environment variables: 
 - `ENV["EMAIL_PASS"]`: the password to the email being used in the mailer. If you don't know this password, we recommend changing the email.
 - `ENV["SECRET_KEY_BASE"]`: secret input for the Rails `key_generator` method
 - `ENV["STRIPE_API_KEY"]`: the secret key for the stripe API 
 - `ENV["STRIPE_PUBLISHABLE_KEY"]`: the public key for the stripe API
 
Heroku addons:
 - the Redis server requires the Heroku Redis addon: to install, run `heroku addons:create heroku-redis:hobby-dev -a [appname]`
