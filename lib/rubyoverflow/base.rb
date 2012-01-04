module Rubyoverflow
  class Base
    class << self
      def fetch(params = {})
        get_response params
      end

      def each_fetch(params = {}, &block)
        get_each_response(params, &block)
      end

      def set_path(pa)
        @@path = pa
      end

      protected

      def get_response in_params, aspect = nil
        params = in_params.clone # in order not to remove :id from original input parameter
        ids = params.delete(:id) if params[:id]
        ids = ids.join(';') if ids and ids.kind_of? Array
        request_path = "#{@@path}#{"/#{ids}" if ids}"
        request_path << "/#{aspect}" if aspect
        hash, url = Rubyoverflow::Client.new.request request_path, params
        Hashie::Mash.new hash
      end

      def get_each_response params, aspect = nil, &block
        return enum_for(:each_fetch, params) unless block_given?

        first_page_res = get_response(params, aspect)
        yield first_page_res

        total, first_page, pagesize = first_page_res.total, first_page_res.page, first_page_res.pagesize
        return unless first_page_res.has_more
        page = params[:page] ? params[:page] + 1 : 2
        yield get_each_response(params.merge(:page => page),aspect)

        self
      end
    end
  end
end
