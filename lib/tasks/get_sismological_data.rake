namespace :sismological_data do
  desc 'Obtain and persist sismological data'
  task fetch: :environment do
    Features::ServiceObjects::FetchAndPersistData.new.fetch_and_persist_data
  end
end
