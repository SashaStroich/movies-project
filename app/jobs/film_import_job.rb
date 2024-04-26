class FilmImportJob < ApplicationJob
  queue_as :default

  def perform(omdb_id, current_user)
    @omdb = OmdbClient.new

    @omdb_film = @omdb.find_by_id(omdb_id)
    
    @film = Film.new(
      name: @omdb_film['Title'],
      cover_image_url: @omdb_film['Poster'],
      release_year: @omdb_film['Year'],
      description: @omdb_film['Plot'],
      duration: @omdb_film['Runtime'],
      director: @omdb_film['Director'],
      genres: @omdb_film['Genre'].split(', ')
    )

    FilmMailer.with(user: current_user, film: @film)
               .import_complete
               .deliver_later if @film.save!
  end
end
