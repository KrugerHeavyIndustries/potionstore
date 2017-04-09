Forward
-------

Potionstore has languished for some time. Having a recent need for something of it's ilk 
I have refreshed Potion Store to support rail5 and hope to continue it's development. 

I may well hard fork it at some point but being rather fond of the name and branding it 
will remain Potion Store for now.

For now watch this space. 

Chris Kruger

Welcome to Potion Store
-----------------------

Features:

- PayPal Website Payments Pro support
- PayPal Express Checkout support
- Administration interface with some simple sales charts
- Coupons
- Send lost license page (http://mycompany.com/store/lost_license)
- Google Analytics e-commerce transaction tracking support for PayPal and credit card orders


Dependencies
------------

- Rails 5.0 or higher.
- PostgreSQL or MySQL


Installation
------------

This is a brief outline of the steps required to get the development environment of Potion Store up
and running on your local machine.

- Install gems via Bundler
  - Run ```bundle install```

- Edit the following config files to suit your needs

  - config/store.yml
  - config/paypal.yml

- Create config/paypal.yml. Modify it with your credentials.
  ```
  # PayPal API Access Setup
  #
  # Instructions:
  #
  # 1. Go to https://developer.paypal.com/.
  # 2. Create an account if you don't have one.
  # 3. Click the "Test Accounts" on the left sidebar.
  # 4. Create a Business Test Account if you don't have one.
  # 5. Select the Business Test Account and click the "Enter Sandbox Test Site" button.
  # 6. Once you log in, click "Profile."
  # 7. Click on "API Access."
  # 8. Click the "Request API Credentials" link.
  # 9. Leave the default selection on "Request API signature" and click the "Agree and Submit" button.
  # 10. Fill in client_id and client_secret with provided values

  # Development settings (sandbox)
  development:
    client_id: XXXXXXXXXXXXXXXXXXXXXXX
    client_secret: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    mode: sandbox
    sandbox_email_address: xxxxx@xxxxx.xxxx

  production:
    client_id: XXXXXXXXXXXXXXXXXXXXXXX
    client_secret: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    mode: live

  ```
- Set session store secret
  Edit config/environment.rb and modify the config.action_controller.session setting

- Setup database
  - Install Postgresql or MySQL if you haven't
  - Create the store_development database.
  	Make sure to set the encoding of the database to UTF8.
	I recommend pgAdmin for Postgresql newcomers.
  - Edit config/database.yml
  - run "rake db:migrate" to create the database schema
   
- Run ```rails s``` and test through
  <http://localhost:3000/store> and
  <http://localhost:3000/admin>

- Replace the default license key generator in lib/licensekey.rb with your own

Debugging
---------

1. ```gem install ruby-debug```
2. Put 'debugger' where you want to break in your source code
3. Start the app with ```rails s --debugger``` to enable breakpoints

  
Final Notes
-----------

I'd appreciate it if you kept the "Powered by Potion Store" link in the footer. It'll help more developers find the project.
