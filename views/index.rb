class GarageMusical
  module Views
    class Index < Layout

      def hello
        "index.rb"
      end
      
      def nick
        @session[:nick]
      end
      
      def name
        @session[:name]
      end
      
      def postings
        @posts.to_a.each do |post|
          {
          :title => post["title"],
          :body  => post["body"],
          :instrument => post["instrument"]
          }
        end
      end
      
    end
  end
end