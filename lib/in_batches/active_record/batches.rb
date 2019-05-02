# frozen_string_literal: true

module ActiveRecord
  module Batches
    def in_batches(of: 1000, begin_at: nil, end_at: nil, load: false)
      relation = self
      unless block_given?
        return BatchEnumerator.new(of: of, begin_at: begin_at, end_at: end_at, relation: self)
      end

      if logger && (arel.orders.present? || arel.taken.present?)
        logger.warn("Scoped order and limit are ignored, it's forced to be batch order and batch size")
      end

      relation = relation.reorder(batch_order).limit(of)
      relation = apply_limits(relation, begin_at, end_at)
      batch_relation = relation

      loop do
        if load
          records = batch_relation.to_a
          ids = batch_relation.pluck(primary_key)
          relation_yielded = self.where(primary_key => ids).reorder(batch_order)
          relation_yielded.load_records(records)
        else
          ids = batch_relation.pluck(primary_key)
          relation_yielded = self.where(primary_key => ids).reorder(batch_order)
        end

        break if ids.empty?

        primary_key_offset = ids.last
        raise ArgumentError.new("Primary key not included in the custom select clause") unless primary_key_offset

        yield relation_yielded

        break if ids.length < of
        batch_relation = relation.where(table[primary_key].gt(primary_key_offset))
      end
    end

    private

    def apply_limits(relation, begin_at, end_at)
      relation = relation.where(table[primary_key].gteq(begin_at)) if begin_at
      relation = relation.where(table[primary_key].lteq(end_at)) if end_at
      relation
    end

    def batch_order
      "#{quoted_table_name}.#{quoted_primary_key} ASC"
    end
  end
end
