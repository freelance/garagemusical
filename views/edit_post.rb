class GarageMusical
  module Views
    class EditPost < Layout

      def title
        @post[:title]
      end

      def instrument
        @post[:instrument]
      end

      def body
        @post[:body]
      end

    end
  end
end