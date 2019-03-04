class GithubClient

  ROOT_ENDPONT = 'https://api.github.com'

  def initialize
    @http_client = setup_http_client
  end

  def create_gist

  end

  private

    def setup_http_client
      Faraday.new(url: ROOT_ENDPONT)
    end
end