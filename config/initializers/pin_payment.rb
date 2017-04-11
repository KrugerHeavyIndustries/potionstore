config = YAML.load(File.read(Rails.root.join('config', 'pin_payment.yml')))
config = config[Rails.env] || {}
PinPayment.public_key = config['public_key']
PinPayment.secret_key = config['secret_key']
PinPayment.api_url = config['api_url'] if config['api_url'].present?
#PinPayment.api_url    = 'http://api.pin.net.au' # Live endpoint, the default is the test endpoint
