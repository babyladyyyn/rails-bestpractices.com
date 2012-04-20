# encoding: utf-8
require 'rails_best_practices/reviews/review'

module RailsBestPractices
  module Plugins
    module Reviews
      class UseTryReview < RailsBestPractices::Reviews::Review
        interesting_nodes :ifop
        interesting_files ALL_FILES

        def start_ifop(node)
          conditional_statement = node.conditional_statement
          first_body = node[2]
          second_body = node[3]
          if :vcall == conditional_statement.sexp_type && :call == first_body.sexp_type && conditional_statement.to_s == first_body.subject.to_s && "nil" == second_body.to_s
            add_error("use try (#{conditional_statement})")
          elsif :call == conditional_statement.sexp_type && :call == second_body.sexp_type && conditional_statement.subject.to_s == second_body.subject.to_s && "nil?" == conditional_statement.message.to_s && "nil" == first_body.to_s
            add_error("use try (#{conditional_statement.subject})")
          end
        end
      end
    end
  end
end
