workers Integer(ENV['PUMA_WORKERS'] || 2)
min_threads = Integer(ENV['MIN_PUMA_THREADS'] || 8)
max_threads = Integer(ENV['MAX_PUMA_THREADS'] || 8)
threads(min_threads, max_threads)

preload_app!

rackup DefaultRackup
port ENV['PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'
