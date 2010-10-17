class GarageMusical
  module Views
    class Profile < Layout

      def hello
        "index.rb"
      end
      
      def nick
        @session[:nick]
      end
      
      def name
        @session[:name]
      end
      
    end
  end
end