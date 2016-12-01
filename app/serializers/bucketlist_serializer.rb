class BucketlistSerializer < ActiveModel::Serializer
  include DateFormat

  attributes :id, :name, :date_created, :date_modified, :created_by

  def created_by
    user_id
  end
end
