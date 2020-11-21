# frozen_string_literal: true

require 'test_helper'

class KrisKringleTest < Minitest::Test
  def test_version_number
    refute_nil ::KrisKringle::VERSION
  end

  def test_sorting_hat_without_csv
    assert_raises KrisKringle::Error do
      KrisKringle.sorting_hat
    end
  end

  def test_sorting_hat_with_csv_data
    assert KrisKringle.sorting_hat(test_csv_data, output: false)
  end

  def test_sorting_hat_with_csv_file
    assert KrisKringle.sorting_hat(test_csv_file, output: false)
  end

  def test_sorting_hat_does_not_include_the_same_matches
    gifters = []
    giftees = []
    match_results = []
    KrisKringle.sorting_hat(test_csv_data, output: false) do |match|
      refute_includes gifters, match[:gifter].name
      refute_includes giftees, match[:giftee].name
      refute_includes match_results, "#{match[:gifter].name} => #{match[:giftee].name}"

      gifters << match[:gifter].name
      giftees << match[:giftee].name
      match_results << "#{match[:gifter].name} => #{match[:giftee].name}"
    end
    assert_equal gifters.size, giftees.size
    assert_equal match_results.size, gifters.size
  end

  def test_sorting_hat_does_not_match_couples
    match_results = []
    KrisKringle.sorting_hat(test_csv_data, output: false) do |match|
      match_results << "#{match[:gifter].name} => #{match[:giftee].name}"
    end
    refute_includes match_results, 'Jarrad => Rebecca'
    refute_includes match_results, 'Rebecca => Jarrad'
  end

  def test_sorting_hat_throws_error_if_duplicate_name_is_encountered
    duplicate_name_test_csv_data = test_csv_data do |csv|
      csv << ['Deandra', '', '0411111118']
    end
    assert_raises KrisKringle::Error do
      KrisKringle.sorting_hat(duplicate_name_test_csv_data, output: false)
    end
  end

  private

  def test_csv_data
    CSV.generate do |csv|
      csv << %w[name partner mobile]
      csv << %w[Jarrad Rebecca 0411111111]
      csv << %w[Rebecca Jarrad 0411111112]
      csv << ['Mac', '', '0411111113']
      csv << ['Charlie', '', '0411111114']
      csv << ['Deandra', '', '0411111115']
      csv << ['Dennis', '', '0411111116']
      csv << ['Frank', '', '0411111117']
      yield(csv) if block_given?
    end
  end

  def test_csv_file
    File.expand_path(File.join(File.dirname(__FILE__), '..', 'test.csv'))
  end
end
