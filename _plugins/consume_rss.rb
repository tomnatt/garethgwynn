class ConsumeRss < Liquid::Tag
  require 'simple-rss'
  require 'open-uri'

  def initialize(tag_name, text, tokens)
    super

    open(URI.encode(text)) do |rss|
      @feed = SimpleRSS.parse(rss).items
    end
  end

  def render(context)
    unless @feed.to_s.empty?
      "<h2>#{@feed.first.title}</h2>
      <p>#{CGI.unescapeHTML(@feed.first.content)}</p>
      <h2>#{@feed[1].title}</h2>
      <p>#{CGI.unescapeHTML(@feed[1].content)}</p>"
    end
  end

  Liquid::Template.register_tag "rss", self
end
