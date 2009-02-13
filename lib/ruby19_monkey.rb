require 'activesupport'

module Ruby19Monkey
  VERSION = "0.0.2"

  def self.install!
    ActionView::Base.send(:include, ForceEncoding::OutputBuffer)
    ActionView::Template.send(:include, ForceEncoding::RenderResult)

    if Rails::VERSION::STRING >= "2.3.0"
      ActionController::Response.send(:include, StringBytesize::ResponseContentLength)
      ActionController::Dispatcher.send(:include, StringEach::RackAppCall)
      ::Rack::File.send(:include, StringEach::RackAppCall)
    else
      ActionController::AbstractResponse.send(:include, StringBytesize::ResponseContentLength)
    end
  end

  module StringEach
    module RackAppCall
      def self.included(base)
        base.alias_method_chain :_call, :string_each_fix
      end

      def _call_with_string_each_fix(env)
        status, _h, body = _call_without_string_each_fix(env)
        header = {}
        _h.each{|k, vs| header[k] = array_or_line_enum(vs) }
        [status, header, array_or_line_enum(body)]
      end

      private
      def array_or_line_enum(obj)
        obj.respond_to?(:each) ? obj : obj.to_s.each_line
      end
    end
  end

  module StringBytesize
    module ResponseContentLength
      def self.included(base)
        base.alias_method_chain :set_content_length!, :string_bytesize
      end
      private
      def set_content_length_with_string_bytesize!
        if "1.8.7 or lator".respond_to?(:bytesize)
          unless body.respond_to?(:call) || (status && status[0..2] == '304')
            self.headers["Content-Length"] ||= body.bytesize
          end
        else
          set_content_length_without_string_bytesize!
        end
      end
    end
  end

  module ForceEncoding
    @@template_encoding = "UTF-8"
    mattr_accessor :template_encoding

    module OutputBuffer
      def self.included(base)
        base.alias_method_chain :output_buffer=, :encoding
      end

      def output_buffer_with_encoding=(out)
        out && out.force_encoding(ForceEncoding.template_encoding)
        self.output_buffer_without_encoding = out
      end
    end

    module RenderResult
      def self.included(base)
        base.alias_method_chain :render_template, :encode
      end

      def render_template_with_encode(v, l = {})
        render_template_without_encode(v, l).tap do |out|
          out && out.force_encoding(ForceEncoding.template_encoding)
        end
      end
    end
  end
end

