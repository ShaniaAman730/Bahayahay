json.extract! dev_project, :id, :title, :property_type, :description, :address, :created_at, :updated_at
json.url dev_projects_url(dev_project, format: :json)
