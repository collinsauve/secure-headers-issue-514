# config.ru
require 'secure_headers'

class App
  def call(_env)
    [200, {}, ["Hello World"]]
  end
end

class AddCookieMiddleware
  def initialize(app, id)
    @app = app
    @id = id
  end

  def call(env)
    status, headers, body = @app.call(env)
    res = Rack::Response.new(body, status, headers)
    res.set_cookie(@id, 'hello')
    res.finish
  end
end

SecureHeaders::Configuration.default do |_config|
end

use AddCookieMiddleware, 'before-sh'
use SecureHeaders::Middleware
use AddCookieMiddleware, 'after-sh-1'
use AddCookieMiddleware, 'after-sh-2'
run App.new