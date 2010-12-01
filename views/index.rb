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
      
      def self_posts
        @self_posts.each do |post|
          post[:creator] = "you"
          post[:replies] = post[:replies].nil? ? 0 : post[:replies]
        end
      end
      
      def postings
        @posts.each do |post|
          post[:creator] = post.creator_nick
          post[:replies] = post[:replies].nil? ? 0 : post[:replies]
        end
      end

    end
  end
end