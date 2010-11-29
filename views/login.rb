class GarageMusical
  module Views
    class Login < Layout

      def hello
        "login.rb"
      end

      def users
        @entries.to_a.first(10)
      end
      
    end
  end
end