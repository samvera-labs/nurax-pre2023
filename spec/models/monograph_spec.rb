# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work_resource Monograph`
require 'rails_helper'
require 'hyrax/specs/shared_specs/hydra_works'

RSpec.describe Monograph do
  subject(:monograph) { described_class.new }
  let(:resource) { monograph }

  it_behaves_like 'a Hyrax::Work'
end
