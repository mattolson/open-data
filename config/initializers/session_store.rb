# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_open-data_session',
  :secret      => '2b97264ffe8bba99faed1ebd0c670b2fd1f9ced6504c5fe9f4a8c19c0b829049b943821ff964fefd7aaa85030c83aca4e4eb09dba2090b764008854b0b12e83b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
