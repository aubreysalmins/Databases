require "album_repository"

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  it 'returns two albums' do
    repo = AlbumRepository.new
    albums = repo.all

    expect(albums.length).to eq(2)
    expect(albums.first.title).to eq('Bossanova')
    expect(albums.first.release_year).to eq('1999')
    expect(albums.first.artist_id).to eq('1')
  end

  it 'returns the first album entry (Bossanova)' do
    repo = AlbumRepository.new

    album = repo.find(1)

    expect(album.artist_id).to eq '1'
    expect(album.title).to eq "Bossanova"
    expect(album.release_year).to eq "1999"
  end

  it "creates a new album" do
    repo = AlbumRepository.new

    album = Album.new
    album.title = 'Trompe le Monde'
    album.release_year = 1991
    album.artist_id = 1

    repo.create(album) # => nil

    all_albums = repo.all

    expect(all_albums).to include(
      have_attributes(
        title: album.title,
        release_year: '1991',
        artist_id: '1')
    )
  end
end