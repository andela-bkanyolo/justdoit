module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_items, only: [:index, :create]

      def index
        render_json(search || paginate)
      end

      def create
        item = @items.create!(item_params)
        render_json(item, :created)
      end

      private

      def item_params
        params.permit(:name, :done)
      end

      def set_items
        @items = get_bucket_list.items
      end

      def get_bucket_list
        current_user.bucketlists.find(params[:bucketlist_id])
      rescue ActiveRecord::RecordNotFound => e
        raise e, Messages.resource_not_found('bucketlist')
      end

      def search
        if params[:q] && @items
          @items.search(params[:q]).paginate(
            params[:limit],
            params[:page]
          )
        end
      end

      def paginate
        @items.paginate(params[:limit], params[:page]) if @items
      end
    end
  end
end
