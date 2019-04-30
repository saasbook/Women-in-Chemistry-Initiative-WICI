# Women In Chemistry Initiative
[![Maintainability](https://api.codeclimate.com/v1/badges/d46360549fe56fe328d4/maintainability)](https://codeclimate.com/github/walkerspence/Women-in-Chemistry-Initiative-WICI/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d46360549fe56fe328d4/test_coverage)](https://codeclimate.com/github/walkerspence/Women-in-Chemistry-Initiative-WICI/test_coverage)
[![Build Status](https://travis-ci.org/walkerspence/Women-in-Chemistry-Initiative-WICI.svg?branch=master)](https://travis-ci.org/walkerspence/Women-in-Chemistry-Initiative-WICI)

http://women-in-chemistry-initiative.herokuapp.com


Make sure to install ImageMagik:
  first run bundle install
  for those with homebrew
  ```bash
  brew install imagemagick
  ```
  On ubuntu
  ```bash
  sudo apt-get install imagemagick
  ```


To run this project locally:
  Decrypt `application.yml` if you have access to the key, or add your own API keys to `secrets.yml`. Then run
  ```bash
  bundle install --without production
  ```
  Once you have installed the gems, run:
  ```bash
  brew install redis 
  ```
  Once Redis has been installed, run:
  ```bash
  redis-server
  ```
  Finally, run 
  ```bash
  rails s
  ```
  and open http://localhost:3000/ in your browser.
