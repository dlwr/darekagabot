class TopController < ApplicationController
  wrap_parameters format: [:json]

  def index
  end

  def callback
    MessageParser.parse(request)
    head 200, content_type: 'text/html'
  end
end
