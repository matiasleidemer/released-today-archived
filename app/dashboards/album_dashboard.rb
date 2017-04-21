require "administrate/base_dashboard"

class AlbumDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    artist: Field::BelongsTo,
    id: Field::Number,
    spotify_id: Field::String,
    name: Field::String,
    image_url: Field::String,
    number_of_tracks: Field::Number,
    released_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :artist,
    :released_at,
    :name,
    :spotify_id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :artist,
    :id,
    :spotify_id,
    :name,
    :image_url,
    :number_of_tracks,
    :released_at,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :artist,
    :spotify_id,
    :name,
    :image_url,
    :number_of_tracks,
    :released_at,
  ].freeze

  # Overwrite this method to customize how albums are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(album)
  #   "Album ##{album.id}"
  # end
end
