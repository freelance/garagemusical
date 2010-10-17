class GarageMusical
  module Views
    class Login < Layout

      def hello
        "login.rb"
      end

      def users
        @entries.to_a.each do |entry|
          {
            :name => entry["name"],
            :nick => entry["nick"]
          }
        end
      end
      
    end
  end
end