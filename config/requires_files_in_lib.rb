Dir[Rails.root + 'lib/google/*.rb'].each do |file|
  require file
end
