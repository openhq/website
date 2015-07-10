workers Integer(ENV['PUMA_WORKERS'] || 2)
threads Integer(ENV['MIN_PUMA_THREADS']  || 8), Integer(ENV['MAX_PUMA_THREADS'] || 8)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'
