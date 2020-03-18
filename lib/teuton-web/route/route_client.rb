
module Sinatra
  module Service
    ##
    #
    module RouteClient

      def self.registered(app)
        app.get '/client/list/*.*' do |path,ext|
          @filename = path+"."+ext
          filepath = File.join(Dir.pwd, @filename)
          data = FileLoader.load(filepath)
          @concepts = data[:concepts]
          @lang = @concepts[0].lang
          @context = @concepts[0].context

          session[ 'clients' ] = @concepts

          @current = File.dirname( filepath )
          erb :"concept/list"
        end

        app.get '/clients/show/:index' do
          @index = params[:index]
          @concepts = session['clients']
          @concept = @concepts[ @index.to_i ]
          puts ConceptHAMLFormatter.new(@concept).to_s
          @filename = @concept.filename
          @current  = File.dirname( File.join( Dir.pwd, @filename) )
          erb :"concept/show"
        end
      end
    end
  end
end
