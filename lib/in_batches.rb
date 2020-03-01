# frozen_string_literal: true

require 'in_batches/version'
require 'active_record'

if defined?(ActiveRecord::Batches::BatchEnumerator)
  warn 'Congratulations on upgrading Rails to 5 or above. You could remove `in_batches` gem now. :)'
else
  require 'in_batches/active_record_extensions'
end
