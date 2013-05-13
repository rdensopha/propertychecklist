#Settings class , which is used for creating app wide constants

class Settings < Settingslogic
   source "#{Rails.root}/config/application.yml"
   namespace Rails.env
end