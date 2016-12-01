module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :set_bucket_list, only: :show
      before_action :set_bucket_lists

      def index
        list = search || paginate
        render_json(list)
      end

      def create
        bucketlist = @bucketlists.create!(bucketlist_params)
        render_json(bucketlist, :created)
      end

      def show
        render_json(@bucketlist)
      end

      private

      def bucketlist_params
        params.permit(:name)
      end

      def set_bucket_list
        @bucketlist = current_user.bucketlists.find_by(id: params[:id])
      end

      def set_bucket_lists
        @bucketlists = current_user.bucketlists
      end

      def search
        if params[:q] && @bucketlists
          @bucketlists.search(params[:q]).paginate(
            params[:limit],
            params[:page]
          )
        end
      end

      def paginate
        @bucketlists.paginate(params[:limit], params[:page]) if @bucketlists
      end
    end
  end
end
