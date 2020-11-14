# frozen_string_literal: true

require 'csv'

require 'kris_kringle/version'
require 'kris_kringle/error'
require 'kris_kringle/participant'
require 'kris_kringle/csv'
require 'kris_kringle/sorting_hat'

module KrisKringle
  module_function

  def sorting_hat(csv = nil, **options, &block)
    raise KrisKringle::Error, 'CSV file required' if csv.nil?

    participants = KrisKringle::CSV.new(csv).process
    KrisKringle::SortingHat.new(participants).matches(options, &block)
  end
end
