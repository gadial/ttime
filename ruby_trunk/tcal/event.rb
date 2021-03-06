#!/usr/bin/env ruby

module TCal
    # contains a calendar event, and is intended for internal use. 
    #
    # [text] the actual info for the event
    # [day] the day of the week (1=sun, 7=sat)
    # [hour] the hour of the day (8.5 is 08:30)
    # [color_id] the id of the color to be used
    # [ratio] the amount of the column taken up by this event
    # [layer] the column of the day the event is in. 0 if it is alone during it's time
    class Event < Struct.new(:text,:day,:hour,:length,:color_id,:ratio,:layer)

        # receives an event and determines if it collides with [self]
        def collides_with?(other)
            if self.day == other.day
                if self.hour >= other.hour and (self.hour) < (other.hour+other.length) or
                    other.hour >= self.hour and (other.hour) < (self.hour+self.length) 
                    return true
                end
            end
            return false 
        end

        # returns the first line of the text of the event
        def name
            self.text =~ /^(.*)$/
                return $1
        end

        # returns the text with the first line marked up to bold
        def markup
            self.text.sub(/^(.*)$/,'<b>\1</b>')
        end

    end

end
