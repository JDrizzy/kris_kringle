# frozen_string_literal: true

module KrisKringle
  class Participant
    attr_reader :name, :partners_name, :mobile

    def initialize(name:, mobile:, partners_name: '')
      @name = name
      @mobile = mobile
      @partners_name = partners_name
    end

    def duplicate_or_partner?(other_participant)
      name == other_participant.name || name == other_participant.partners_name
    end
  end
end
