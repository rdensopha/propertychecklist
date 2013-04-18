class HomeController < ApplicationController
  def index
    @projects = Project.all
  end

  def listProjectAlphabetically(alphabet)
        projects_with_alphabet =[]
        @projects.each do |project_info|
           projects_with_alphabet << project_info if  project_info.name.downcase.start_with?(alphabet)
        end
        projects_with_alphabet
  end

  helper_method :listProjectAlphabetically
end
