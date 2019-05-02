# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'in_batches'

require 'minitest/autorun'

ActiveRecord::Base.establish_connection(
  'adapter'  => 'sqlite3',
  'database' => ':memory:',
)
require 'lib/seeds'

def in_sandbox
  ActiveRecord::Base.transaction do
    yield
    fail ActiveRecord::Rollback
  end
end

def assert_queries(expected_count, event_key = 'sql.active_record')
  sqls = []
  subscriber = ActiveSupport::Notifications.subscribe(event_key) do |_, _, _, _, payload|
    sqls << "  ● #{payload[:sql]}" if payload[:sql] !~ /\A(?:BEGIN TRANSACTION|COMMIT TRANSACTION)/i
  end
  yield
  if expected_count != sqls.size # show all sql queries if query count doesn't equal to expected count.
    assert_equal "expect #{expected_count} queries, but have #{sqls.size}", "\n#{sqls.join("\n").gsub('"', "'")}\n"
  end
  assert_equal expected_count, sqls.size
ensure
  ActiveSupport::Notifications.unsubscribe(subscriber)
end