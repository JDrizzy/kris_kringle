# frozen_string_literal: true

module KrisKringle
  class CSV
    def initialize(data)
      @data = data
    end

    def process
      participants = []
      data = File.read(@data) if @data.is_a?(String) && @data.end_with?('.csv')
      data = @data if data.nil?
      ::CSV.parse(data, headers: true).each do |csv|
        duplicate_participant?(participants, csv['name'])
        participants << Participant.new(
          name: csv.delete('name').last,
          partners_name: csv.delete('partner').last,
          other_details: csv.to_h
        )
      end
      participants
    end

    private

    def duplicate_participant?(participants, new_participants_name)
      return if participants.empty?

      index = participants.find_index { |p| p.name == new_participants_name }
      raise KrisKringle::Error, 'Duplicate participant encountered. Names must be unique' if !index.nil?
    end
  end
end
