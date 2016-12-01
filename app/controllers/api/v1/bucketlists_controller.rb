module Api
  module V1
    class BucketlistsController < ApplicationController
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
