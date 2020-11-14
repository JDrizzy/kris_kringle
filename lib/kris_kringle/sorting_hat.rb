# frozen_string_literal: true

module KrisKringle
  class SortingHat
    def initialize(participants)
      @participants = participants
      @giftees = []
      @gifters = []
      @matches = []
      match_participants
    end

    def matches(options = default_options)
      @matches.each do |match|
        if options[:output]
          if options[:anonymous]
            puts "Gifter: #{match[:gifter].object_id} => Giftee: #{match[:giftee].object_id}"
          else
            puts "Gifter: #{match[:gifter].name} => Giftee: #{match[:giftee].name}"
          end
        end
        yield(match) if block_given?
      end
      true
    end

    private

    def default_options
      {
        output: true,
        anonymous: false
      }
    end

    def match_participants
      loop do
        reset_matches if @gifters.empty?
        gifter = @gifters.pop
        @giftees.each_with_index do |giftee, index|
          next if giftee_and_gifter_are_the_same?(gifter, giftee)
          next if giftee_and_gifter_are_partners?(gifter, giftee)

          @matches << {
            gifter: gifter,
            giftee: giftee
          }
          @giftees.delete_at(index)
          break
        end

        break if @matches.size == @participants.size
      end
    end

    def giftee_and_gifter_are_the_same?(gifter, giftee)
      gifter.name == giftee.name
    end

    def giftee_and_gifter_are_partners?(gifter, giftee)
      gifter.name == giftee.partners_name
    end

    def reset_matches
      @giftees = @participants.shuffle
      @gifters = @participants.shuffle
      @matches = []
    end
  end
end
