module IrcMachine
  module Controller
    class ChannelsController < HttpController

      def list
        content_type "application/json"
        ok session.state.channels.to_json << "\n"
      end

      def join
        session.join channel(match), request.GET["key"]
      end

      def part
        session.part channel(match)
      end

      def message
        input = request.body.gets
        source = request.env["HTTP_X_AUTH"] || request.ip || "unknown"
        session.msg channel(match), "[#{source}] #{input.chomp}" if input
      end

      private

      def channel(match)
        "#" + match[1]
      end

    end
  end
end
