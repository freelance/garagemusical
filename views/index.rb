class GarageMusical
  module Views
    class Index < Layout

      def hello
        "index.rb"
      end
      
      def nick
        @user["nick"]
      end
      
      def name
        @user['name']
      end
      
      def postings
        @posts.to_a
      end
      
    end
  end
end