# frozen_string_literal: true

module ActiveRecord
  module Querying
    delegate :in_batches, to: :all
  end
end
