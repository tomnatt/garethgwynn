class EmbedYoutube < Liquid::Tag

    def initialize(tag_name, text, tokens)
        super
        # can't chain this, else you'll get the sliced bit back
        text.slice!("http://youtu.be/")
        @text = text
    end
 
    def render(context)
        "<iframe width=\"420\" height=\"315\" src=\"//www.youtube.com/embed/#{@text}\" frameborder=\"0\" allowfullscreen></iframe>"
    end

    Liquid::Template.register_tag "youtube", self
    
end
