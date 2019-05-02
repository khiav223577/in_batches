# frozen_string_literal: true

require 'in_batches/version'
require 'active_record'
require 'in_batches/active_record_extensions' if not defined?(ActiveRecord::Batches::BatchEnumerator)
