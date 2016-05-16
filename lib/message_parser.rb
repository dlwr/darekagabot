module MessageParser
  class << self
    def parse(request)
      return false unless signature_valid?(request)
      message = JSON.parse(request.body.read, symbolize_names: true)
      message[:result].each do |result|
        puts result
        if result[:content][:contentType] != 1
          return
        end
        text = result[:content][:text]
        puts text
        line_mid = result[:content][:from]
        ArticleSubmitter.submit(text)
        article = Article.new(text: text, user: User.find_or_create_by(line_mid: line_mid))
        article.save
      end
    end

    def signature_valid?(request)
      secret = Rails.application.secrets.line['channel_secret']
      body = request.raw_post
      hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, secret, body)
      signature = Base64.strict_encode64(hash)
      puts signature
      puts request.headers['X-LINE-ChannelSignature']
      request.headers['X-LINE-ChannelSignature'] == signature
    end
  end
end
