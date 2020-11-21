# frozen_string_literal: true

module KrisKringle
  class Participant
    attr_reader :name, :partners_name, :other_details

    def initialize(name:, partners_name: '', other_details: {})
      @name = name
      @partners_name = partners_name
      @other_details = other_details
    end

    def duplicate_or_partner?(other_participant)
      name == other_participant.name || name == other_participant.partners_name
    end
  end
end
