class ConsumeRss < Liquid::Tag

    require 'simple-rss'
    require 'net/http'
    require 'cgi'

    def initialize(tag_name, text, tokens)
        super

        # get the feed
        url = URI.parse(text)
        req = Net::HTTP::Get.new(url.path)
        res = Net::HTTP.get(url) {|http|
            http.request(req)
        }

        # get the first item in a useful format
        @feed = SimpleRSS.parse(res).items

    end
 
    def render(context)
        "<h2>#{@feed.first.title}</h2>
        <p>#{CGI.unescapeHTML(@feed.first.content)}</p>
        <h2>#{@feed[1].title}</h2>
        <p>#{CGI.unescapeHTML(@feed[1].content)}</p>"
    end
 
    Liquid::Template.register_tag "rss", self
    
end
