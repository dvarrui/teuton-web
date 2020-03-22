
require_relative '../application'

##
# Sinatra.Service.Helpers
module Sinatra
  module Service
    ##
    # Sinatra TeutonWeb helpers
    module MainHelper

      def f2s(filepath)
        filepath.gsub('/','$')
      end

      def s2f(string)
        string.gsub('$','/')
      end

      def get_dirpath_from(input)
        s2f(input)
      end

      def get_testname_from(input)
        File.basename(s2f(params[:input]))
      end

      def get_vardir_from(input)
        File.join('var', get_testname_from(input))
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
