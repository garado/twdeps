require 'test_helper'

module TaskWarrior
  module Test
    class TestGraph < MiniTest::Test
      include TaskWarrior::Test::Fixtures

      def setup
        repo = TaskWarrior::Repository.new(File.read(fixture('party_taxes.json')))
        plain = TaskWarrior::Dependencies::Graph.new(self.class.name)

        repo.tasks.each do |task|
          plain << task
        end

        @graph = TaskWarrior::Test::PlainGraphParser.new(plain.render(:plain))
      end

      def test_nodes
        assert_equal(8, @graph.nodes.size)

        assert_node("6fd0ba4a-ab67-49cd-ac69-64aa999aff8a", "Select a free weekend in November")
        assert_node("c992448a-f1ea-4982-8461-47f0705ff509", "Select and book a venue")
        assert_node("3b53178e-d5a4-45e0-afc2-1292db58a59a", "Mail invitations")
        assert_node("9f6f3738-1c08-4f45-8eb4-1e90864c7588", "Print invitations")
        assert_node("e5a867b7-0116-457d-ba43-9ac2bee6ad2a", "Design invitations")
        assert_node("c590941b-eb10-4569-bdc9-0e339f79305e", "Select a caterer")
        assert_node("b587f364-c68e-4438-b4d6-f2af6ad62518", "Pay taxes")
      end

      def test_edges
        assert_equal(6, @graph.edges.size)
        refute_nil(@graph.edge('6fd0ba4a-ab67-49cd-ac69-64aa999aff8a', 'c992448a-f1ea-4982-8461-47f0705ff509'))
        refute_nil(@graph.edge('9f6f3738-1c08-4f45-8eb4-1e90864c7588', '3b53178e-d5a4-45e0-afc2-1292db58a59a'))
        refute_nil(@graph.edge('e5a867b7-0116-457d-ba43-9ac2bee6ad2a', '9f6f3738-1c08-4f45-8eb4-1e90864c7588'))
        refute_nil(@graph.edge('c992448a-f1ea-4982-8461-47f0705ff509', 'e5a867b7-0116-457d-ba43-9ac2bee6ad2a'))
        refute_nil(@graph.edge('6fd0ba4a-ab67-49cd-ac69-64aa999aff8a', 'c590941b-eb10-4569-bdc9-0e339f79305e'))
        refute_nil(@graph.edge('c992448a-f1ea-4982-8461-47f0705ff509', 'c590941b-eb10-4569-bdc9-0e339f79305e'))
      end

      private
      def assert_node(id, label)
        node = @graph.node(id)
        refute_nil(node)
        assert_equal(id, node.id)
        assert_equal(label, node.label)
      end
    end
  end
end
