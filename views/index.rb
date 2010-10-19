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
        @posts.to_a.each do |post|
          post[:creator] = post.creator_nick
        end
      end

    end
  end
end