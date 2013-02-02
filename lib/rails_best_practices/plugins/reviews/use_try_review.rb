# encoding: utf-8
require 'rails_best_practices/reviews/review'

module RailsBestPractices
  module Plugins
    module Reviews
      class UseTryReview < RailsBestPractices::Reviews::Review
        interesting_nodes :ifop
        interesting_files ALL_FILES

        add_callback :start_ifop do |node|
          conditional_statement = node.conditional_statement
          true_body = node[2]
          second_body = node[3]
          if assert_type?(conditional_statement, :vcall) &&
             assert_type?(true_body, :call) &&
             str_equal?(conditional_statement, true_body.receiver) &&
             assert_str?(second_body, "nil")
            # user ? user.name : nil
            add_error("use try (#{conditional_statement})")
          elsif assert_type?(conditional_statement, :call) &&
                assert_type?(second_body, :call) &&
                str_equal?(conditional_statement.receiver, second_body.receiver) &&
                assert_str?(conditional_statement.message, "nil?") &&
                assert_str?(true_body, "nil")
            # user.nil? ? nil : user.name
            add_error("use try (#{conditional_statement.receiver})")
          end
        end

        private
        def assert_type?(node, type)
          type == node.sexp_type
        end

        def assert_str?(node, str)
          str == node.to_s
        end

        def str_equal?(node1, node2)
          node1.to_s == node2.to_s
        end
      end
    end
  end
end
