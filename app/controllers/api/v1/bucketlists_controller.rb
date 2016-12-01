module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :set_bucket_lists

      def index
        render_json(paginate)
      end

      def create
        bucketlist = @bucketlists.create!(bucketlist_params)
        render_json(bucketlist, :created)
      end

      private

      def bucketlist_params
        params.permit(:name)
      end

      def set_bucket_lists
        @bucketlists = current_user.bucketlists
      end

      def paginate
        @bucketlists.paginate(params[:limit], params[:page]) if @bucketlists
      end
    end
  end
end
