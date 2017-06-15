unless Rails.env == 'test'
  RSpotify.authenticate(
    Rails.application.secrets.client_id,
    Rails.application.secrets.client_secret
  )
end
