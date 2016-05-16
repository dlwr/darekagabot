require 'net/http'

module ArticleChecker
  class << self
    def fetch(url, limit = 10)
      raise ArgumentError, 'HTTP redirect too deep' if limit == 0
      req = Net::HTTP::Get.new(url.path, { 'User-Agent' => 'Mozilla/5.0' })
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
      case response
      when Net::HTTPSuccess then response
      when Net::HTTPRedirection
        next_url = URI.parse(response['location'])
        if next_url.relative?
          next_url.scheme = url.scheme
          next_url.host = url.host
        end
        fetch(next_url, limit - 1)
      else
        response.error!
      end
    end

    def check
      url = URI.parse('http://darekagakaku.herokuapp.com/')
      res = fetch(url)
      text = Oga.parse_xml(res.body).css("div.content p").map(&:text).join("\n").force_encoding("utf-8")
      latest = Article.last
      if latest.text != text
        article = Article.new(text: text)
        article.save
      end
    end
  end
end
