class GarageMusical
  module Views
    class Profile < Layout
#      use Quickedit
      include Quickedit::Helpers

      def hello
        "index.rb"
      end
      
      def nick
        quickedit(@session)[:nick]
      end
      
      def name
        quickedit(@session)[:name]
      end
      
    end
  end
end