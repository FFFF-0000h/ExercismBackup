import java.util.*;

class RelativeDistance {
    private Map<String, List<String>> familyTree;

    RelativeDistance(Map<String, List<String>> familyTree) {
        this.familyTree = familyTree;
    }

    int degreeOfSeparation(String personA, String personB) {
        if (personA.equals(personB)) {
            return 0;
        }

        // Build an undirected graph from the family tree
        Map<String, Set<String>> graph = new HashMap<>();

        for (Map.Entry<String, List<String>> entry : familyTree.entrySet()) {
            String child = entry.getKey();
            List<String> parents = entry.getValue();

            graph.putIfAbsent(child, new HashSet<>());

            // Connect child to each parent
            for (String parent : parents) {
                graph.putIfAbsent(parent, new HashSet<>());
                graph.get(child).add(parent);
                graph.get(parent).add(child);
            }

            // Connect siblings (parents) directly to each other
            for (int i = 0; i < parents.size(); i++) {
                for (int j = i + 1; j < parents.size(); j++) {
                    graph.get(parents.get(i)).add(parents.get(j));
                    graph.get(parents.get(j)).add(parents.get(i));
                }
            }
        }

        // BFS to find shortest path
        if (!graph.containsKey(personA) || !graph.containsKey(personB)) {
            return -1;
        }

        Queue<String> queue = new LinkedList<>();
        Map<String, Integer> distance = new HashMap<>();

        queue.offer(personA);
        distance.put(personA, 0);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            int currentDist = distance.get(current);

            if (current.equals(personB)) {
                return currentDist;
            }

            for (String neighbor : graph.get(current)) {
                if (!distance.containsKey(neighbor)) {
                    distance.put(neighbor, currentDist + 1);
                    queue.offer(neighbor);
                }
            }
        }

        return -1;  // No connection found
    }
}