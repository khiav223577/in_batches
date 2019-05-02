# frozen_string_literal: true

require 'in_batches/active_record/relation/batch_enumerator'
require 'in_batches/active_record/batches'

class ActiveRecord::Base
  def self.in_batches(*args)
    where('').in_batches(*args)
  end
end
