
module Sinatra
  module Service
    module RouteFile

      def self.registered(app)
        app.get '/file/show/*.*' do |path,ext|
          @filename = path+"."+ext
          filepath = File.join( Dir.pwd, @filename)
          content = load_file filepath
#          @filecontent = CodeRay.scan(content, ext.to_sym).div(:line_numbers => :table)
          @filecontent = "<pre>#{content}</pre>"
          @concepts = session['concepts']
          @current = File.dirname(filepath)
          erb :"file/show"
        end

        app.get '/file/delete/*' do
          filepath = File.join( Dir.pwd, params[:splat] )
          dirpath = File.dirname(filepath)
          FileUtils.rm(filepath)
          redirect "/dir/list/#{route_for(dirpath)}"
        end

        app.post '/file/new' do
          filepath = File.join( params[:basedir], params[:filename] )
          if params[:type]=='file' then
            redirect "/file/create/#{filepath}"
          elsif params[:type]=='dir' then
            redirect "/dir/create/#{filepath}"
          end
        end

        app.get '/file/create/*' do |name|
          filename = name+".haml"
          @current=File.join( Project.instance.inputbasedir, filename )
          Builder::create_hamlfile(@current)
          redirect "/concept/list/#{route_for(@current)}"
        end
      end

    end
  end
end
