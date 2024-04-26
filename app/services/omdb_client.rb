class OmdbClient
    URL ='http://www.omdbapi.com'
    
    def initialize
      @api_key = Rails.application.credentials.omdb[:apikey]
    end
    
    def search(string)
      parse_body(
        Faraday.get(URL, {apikey: @api_key, s: string})
      )
    end

    def find_by_title(title)
      parse_body(
        Faraday.get(URL, { apikey: @api_key, t: title})
      )
    end

    def find_by_id(id)
      parse_body(Faraday.get(URL, { apikey: @api_key, i: id }))
    end

    private
    def parse_body(responce)
      JSON.parse(responce.body)
    end
  end