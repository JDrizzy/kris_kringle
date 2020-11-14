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
        participants << Participant.new(
          name: csv['name'],
          mobile: csv['mobile'],
          partners_name: csv['partner']
        )
      end
      participants
    end
  end
end
