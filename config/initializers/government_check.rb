class SiteInspector
  class Endpoint
    class Government < Check
      def government?
        require 'gman'
        Gman.valid? host
      end

      def slash_data?
        endpoint.content.path_exists?("/data")
      end

      def slash_developer?
        endpoint.content.path_exists?("/developer") || endpoint.content.path_exists?("/developers")
      end

      def data_dot_json?
        endpoint.content.path_exists?("/data.json")
      end

      def to_h
        {
          :government      => government?,
          :slash_data      => slash_data?,
          :slash_developer => slash_developer?,
          :data_dot_json   => data_dot_json?
        }
      end
    end
  end
end
