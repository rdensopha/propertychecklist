heroku_config_file = File.expand_path("../../heroku.yml",__FILE__)
if File.exists?(heroku_config_file)
  external_service_config = YAML.load_file(heroku_config_file)
  external_service_config.fetch(Rails.env,{}).each do |key,value|
     ENV[key.upcase] = value.to_s
  end  
end
