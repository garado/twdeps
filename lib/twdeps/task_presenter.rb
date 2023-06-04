module TaskWarrior
  module Dependencies
    #
    # Presents a task's attributes suitable for a GraphViz node
    #
    class TaskPresenter < Presenter
      def initialize(task)
        self.id = task.uuid
        self.attributes = {
          :label => task.description,
          :fontcolor => $fg,
          :fontname => $fontname,
          :color => $nodebg,
          :shape => 'rectangle',
          :fillcolor => $nodebg,
          :style => 'filled, rounded',
        }

        if task.id == Integer($selected_taskid)
          self.attributes.merge!({
            :fontcolor => $selfg,
            :color => $selfg,
            :fillcolor => $selbg,
          })
        end

        if :completed == task.status
          self.attributes.merge!({:fontcolor => $green, :color => $green})
        end
      end
    end
  end
end
