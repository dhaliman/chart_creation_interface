class String
  # converts json to a hash
  def json_to_hash
    JSON.parse(self)
  end
end
