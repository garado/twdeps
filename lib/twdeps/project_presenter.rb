module TaskWarrior
  module Dependencies
    #
    # Presents a project's attributes suitable for a GraphViz cluster
    #
    class ProjectPresenter < Presenter
      def initialize(project)
        self.id = "cluster_#{project.name}"
        self.attributes = {
          :label => project.name,
          :fontname => $fontname,
          :pencolor => '#bf616a',
          :fontcolor => '#bf616a',
          :style => 'invis'
        }
      end
    end
  end
end
