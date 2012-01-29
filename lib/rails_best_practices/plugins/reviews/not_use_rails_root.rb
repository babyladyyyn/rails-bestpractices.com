# encoding: utf-8
require 'rails_best_practices/reviews/review'

module RailsBestPractices
  module Plugins
    module Reviews
      class NotUseRailsRootReview < RailsBestPractices::Reviews::Review
        interesting_nodes :var_ref
        interesting_files ALL_FILES

        def start_var_ref(node)
          if node.to_s == "RAILS_ROOT"
            add_error "not use RAILS_ROOT"
          end
        end
      end
    end
  end
end
