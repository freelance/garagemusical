class GarageMusical
  module Views
    class Browse < Layout
      
      def hello
        "temp.rb"
      end

      def postings_left
        @posts[0...@posts.size/2].each do |post|
          post[:creator] = post.creator_nick
        end
      end
      
      def postings_right
        @posts[@posts.size/2..-1].each do |post|
          post[:creator] = post.creator_nick
        end
      end

    end
  end
end
