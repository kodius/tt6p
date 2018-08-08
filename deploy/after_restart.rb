def self.list_environment
  result = {}
  node[:deploy].each do |_, deploy|
    deploy[:environment_variables].each do |key, value|
      result[key] = value
    end
  end
  result
end

Chef::Log.info("Kill puma cable server")
execute "kill puma cable server" do
  cwd release_path
  command "pkill -f tcp://0.0.0.0:28080"
  environment(list_environment)
  ignore_failure true
end

Chef::Log.info("Restart action cable server")
execute "run puma cable server" do
  cwd release_path
  command "bundle exec puma -p 28080 -d cable/config.ru"
  environment(list_environment)
end

# Chef::Log.info("Staging workers")
# execute "start workers" do
#   cwd "/srv/www/platiplus/current/config/"
#   environment(list_environment)
#   command "./restart_workers.sh"
#   user "root"
# end
