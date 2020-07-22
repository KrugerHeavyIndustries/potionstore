config = YAML.load(File.read(Rails.root.join('config', 'pin_payments.yml')))
config = config.fetch(Rails.env, {})
PinPayment.public_key = config.fetch('public_key')
PinPayment.secret_key = config.fetch('secret_key')
PinPayment.api_url = config.fetch('api_url') if config['api_url']
#PinPayment.api_url    = 'http://api.pinpayments.com' # Live endpoint, the default is the test endpoint
