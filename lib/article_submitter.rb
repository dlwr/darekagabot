module ArticleSubmitter
  class << self
    def submit(text)
      url = URI.parse('http://darekagakaku.herokuapp.com/w')
      http = Net::HTTP.new(url.host, url.port)

      req = Net::HTTP::Post.new(url.path)
      req.set_form_data('text' => text)

      res = http.request(req)
    end
  end
end
