class ConsumeRss < Liquid::Tag
  require 'simple-rss'
  require 'open-uri'

  def initialize(tag_name, text, tokens)
    super

    text.strip!
    if text =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
      URI.open(text) do |rss|
        @feed = SimpleRSS.parse(rss).items
      end
    end
  end

  def render(context)
    unless @feed.to_s.empty?
      "<h2>#{@feed.first.title}</h2>
      <p>#{CGI.unescapeHTML(@feed.first.content)}</p>"
    end
  end

  Liquid::Template.register_tag "rss", self
end
