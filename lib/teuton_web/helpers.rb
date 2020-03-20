
require_relative 'application'

##
# Sinatra.Service.Helpers
module Sinatra
  module Service
    ##
    # Sinatra TeutonWeb helpers
    module Helpers

      def f2s(filepath)
        filepath.gsub('/','$')
      end

      def s2f(string)
        string.gsub('$','/')
      end

      def remove_basedir(dir)
        items = @current.split(File::SEPARATOR)
        items.delete(".")
        items.delete("..")
        items.delete(BASEDIR)
        return File.join(items,File::SEPARATOR)
      end

      def html_for_current( option={ :indexlast => false} )
        output = "<a href=\"/dir/list\">Home</a>"
        relative_path = route_for @current
        return output if relative_path.nil?

        items = relative_path.split(File::SEPARATOR)
        before = ""
        items.each do |i|
          if i==items.last and option[:indexlast]==false then
            output += "/"+i
          else
            before=before+"/"+i
            output += "/<a href=\"/dir/list"+before+"\">"+i+"</a>"
          end
        end
        return output
      end

      def html_for_navbar
        text = <<-DIV
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">TEUTON</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
        DIV

        text += '<li class="active"><a href="/' + @mode.to_s.downcase + '">Mode: ' + @mode.to_s+ '</a></li>'
        text += '<li><a href="https://github.com/dvarrui/teuton-web">GitHub</a></li>'
        text += <<-DIV
        <li><a href="https://github.com/dvarrui/teuton-web/blob/master/README.md">Documentation
        DIV
        text += ' (' + TeutonWeb::Application::VERSION + ')</a></li>'
        text += '</ul></div> <!--/.nav-collapse -->'
        text
      end
    end
  end
end
