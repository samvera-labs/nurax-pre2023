# Generated via
#  `rails generate hyrax:work GenericWork`

module Hyrax
  class GenericWorksController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::GenericWork
  end
end
