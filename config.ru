# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application

# https://www.phusionpassenger.com/library/config/standalone/tuning_sse_and_websockets/#performance-tuning
PhusionPassenger.advertised_concurrency_level = 0 if defined?(PhusionPassenger)
