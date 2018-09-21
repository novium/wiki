defmodule Wiki.ElasticsearchCluster do
  use Elasticsearch.Cluster, otp_app: :wiki
end
