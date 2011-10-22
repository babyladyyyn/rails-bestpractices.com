require 'spec_helper'

describe PaginateCell do
  context "cell instance" do
    subject { cell(:paginate) }

    it { should respond_to(:show) }
  end
end
