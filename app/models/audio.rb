class Audio < ActiveRecord::Base
  belongs_to :post

  attr_accessible :url, :bytes

  delegate :title, :to => :post, :prefix => true

  validates :url, :presence => true, :uniqueness => true

  def torrent_url
    # Pasa de //venganzasdelpasado.com.ar/2011/lavenganza_2011-11-22[_90].mp3
    #       a    http://s3.schwindt.org/dolina/2011/lavenganza_2011-11-22[_90].mp3?torrent
    # Las contribuciones de los usuarios tienen _id de media antes de .mp3
    url.sub %r[.*//venganzasdelpasado.com.ar(/\d{4}/lavenganza_\d{4}-\d{2}-\d{2}.*\.mp3)$],
            'http://s3.schwindt.org/dolina\1?torrent'
  end
end
