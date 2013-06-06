# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)

timeout 15

preload_app true

# based on the recommendation from shopify blog; will check if a connection is still open 
# before processing the request.
check_client_connection true

listen ENV['PORT'], :backlog => Integer(ENV['UNICORN_BACKLOG'] || 200)

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end 

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end