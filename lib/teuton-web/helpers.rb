
##
# Sinatra.Service.Helpers
module Sinatra
  module Service
    ##
    # Sinatra TeutonWeb helpers
    module Helpers

      BASEDIR = Dir.pwd # Base directory

      def route_for(path)
        s = BASEDIR.size + 1
        return path[s,100]
      end

      def remove_basedir(dir)
        items=@current.split(File::SEPARATOR)
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
            <li class="active"><a href="/">Mode</a></li>
            <li><a href="https://github.com/teuton-software/teuton">GitHub</a></li>
            <li><a href="https://github.com/teuton-software/teuton/blob/master/README.md">Documentation</a></li>
          </ul>
        </div> <!--/.nav-collapse -->
        DIV
        return text
      end

    end
  end
end
