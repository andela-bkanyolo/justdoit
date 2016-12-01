module API
  module V1
    class Api::V1::BucketlistsController < ApplicationController
      def create
        bucketlist = @current_user.bucketlists.create!(bucketlist_params)
        render_json(bucketlist, :created)
      end

      private

      def bucketlist_params
        params.permit(:name)
      end
    end
  end
end
