# frozen_string_literal: true

require 'test_helper'

class InBatchesTest < Minitest::Test
  def setup
  end

  def test_that_it_has_a_version_number
    refute_nil ::InBatches::VERSION
  end

  def test_update_all
    in_sandbox do
      assert_queries(2){ User.in_batches.update_all('money = money + 1') }
      assert_equal [101, 201, 1], User.order(:id).pluck(:money)
    end
  end

  def test_update_all_with_low_batch_num
    in_sandbox do
      assert_queries(4){ User.in_batches(of: 2).update_all('money = money + 1') }
      assert_equal [101, 201, 1], User.order(:id).pluck(:money)
    end
  end

  def test_block
    User.in_batches(of: 2).each_with_index do |users, index|
      case index
      when 0 ; assert_equal [100, 200], users.map(&:money)
      when 1 ; assert_equal [0], users.map(&:money)
      end
    end
  end
end
