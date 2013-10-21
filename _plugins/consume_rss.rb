class ConsumeRss < Liquid::Tag
 
    def initialize(tag_name, text, tokens)
        super
        @text = text
    end
 
    def render(context)
        "RSS feed here - some text: #{@text}"
    end
 
    Liquid::Template.register_tag "rss", self
    
end
