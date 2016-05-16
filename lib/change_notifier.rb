class ChangeNotifier
  class << self
    def notify_for(article, user)
      url = URI.parse('https://trialbot-api.line.me/v1/events')
      http = Net::HTTP.new(url.host, url.port)

      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(url.path)

      req["Content-type"] = "application/json"
      req["X-Line-ChannelID"] = Rails.application.secrets.line['channel_id']
      req["X-Line-ChannelSecret"] = Rails.application.secrets.line['channel_secret']
      req["X-Line-Trusted-User-With-ACL"] = Rails.application.secrets.line['channel_mid']

      req.body = {
        to: [ user.line_mid ],
        toChannel: 1383378250,
        eventType: "138311608800106203",
        content: {
          contentType: 1,
          toType: 1,
          text: article.text
        }
      }.to_json

      res = http.request(req)
    end

    def notify_multicast(article)
      User.all.find_each do |user|
        if article.user != user
          notify_for(article, user)
        end
      end
    end
  end
end
