require 'goliath'
require 'artii'

VERSION = '0.1.2'.freeze

class ArtiiAPI < Goliath::API
  # Render static files from ./public
  use(Rack::Static,
    :root  => Goliath::Application.app_path('public'),
    :urls  => ['/favicon.ico', '/stylesheets'],
    :index => '/index.html')
  use Goliath::Rack::Params

  # You must use either maps or response, but never both!
  def response(env)
    case env[ 'PATH_INFO' ]
      when '/make'
        options = params['font'] ? {:font => params['font'].to_s} : {}
        begin
          [200, {'Content-Type' => 'text/plain'}, Artii::Base.new(options).asciify(params['text'].to_s)]
        rescue
          [500, {'Content-Type' => 'text/plain'}, 'An error has occurred while asciifying.']
        end
      when '/fonts_list'
        [200, {'Content-Type' => 'text/plain'}, Artii::Base.new.all_fonts.keys.join("\n")]
    end
    #raise "#response is ignored when using maps, so this exception won't raise. See spec/integration/rack_routes_spec."
  end
end
