module TaskWarrior
  module Dependencies
    #
    # Presents a task's attributes suitable for a GraphViz node
    #
    class TaskPresenter < Presenter
      def initialize(task)
        # Set colors
        _color = $nodebg
        _fontcolor = $fg
        _sbfg = $sbfg

        if $selected_taskid == task.id
          _sbfg = $selsbfg # sublabel fg
          _fontcolor = $selfg
          _fillcolor = $selbg
          _color = $selfg
        end

        if :completed == task.status
          _subtext = "Complete!"
          _sbfg = $green
          _fontcolor = $green
          _color = $green
        else
          _subtext = "ID: #{task.id}"
        end

        # Manual text wrapping
        # shoutout https://biowize.wordpress.com/2011/03/11/text-wrapping-with-dot-graphviz/
        maxwidth = 25
        words = task.description.split(/\W+/)
        newline = ""
        newtext = Array.new
        words.each { |w|
          if newline.length > 0 and 
              ((newline.length + w.length) > maxwidth)
            newtext.append(newline)
            newline = ""
          end

          if newline.length > 0
            newline += " "
          end

          newline += w
        }

        if newline.length > 0
          newtext.append(newline)
        end

        desc = newtext.join("<BR />")

        self.id = task.uuid
        self.attributes = {
          :label => "<#{desc}<BR /> <FONT POINT-SIZE='10' COLOR='#{_sbfg}'>#{_subtext}</FONT>>",
          :fontname => $fontname,
          :fillcolor => $nodebg,
          :shape => 'rectangle',
          :style => 'filled, rounded',
          :fontcolor => _fontcolor,
          :color => _color,
        }
      end
    end
  end
end
