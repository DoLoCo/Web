module Api
  module V1
    class CampaignsController < Api::ApplicationController
      before_action :authenticate, only: []

    end
  end
end