class GarageMusical
  module Views
    class Profile < Layout

      def hello
        "index.rb"
      end
      
      def nick
        @user[:nick]
      end
      
      def name
        @user[:name]
      end
      
      def postings
        @postings.to_a.each do |post|
          {
            :creator => @user[:nick]
          }
        end
      end
      
    end
  end
end