# moovup_test

Moovup Test

## Question 1

Use the following undirected graph ­- nodes can be visited only once:

![List](assets/graph_test.png)


```
import 'dart:collection';

void main() {
  // Define the graph
  Map<String, List<String>> graph = {
    'A': ['B', 'D'],
    'B': ['A', 'C', 'D'],
    'C': ['B', 'D', 'F'],
    'D': ['A', 'B', 'C', 'E'],
    'E': ['D', 'F', 'H'],
    'F': ['C', 'E', 'G'],
    'G': ['F', 'H'],
    'H': ['A','E', 'G']
  };

  // a. Get all possible paths between A-H
  List<List<String>> getAllPaths(String start, String end) {
    List<List<String>> paths = [];
    Queue<List<String>> queue = Queue();
    queue.add([start]);

    while (queue.isNotEmpty) {
      List<String> currentPath = queue.removeFirst();
      String currentNode = currentPath.last;

      if (currentNode == end) {
        paths.add(currentPath);
      } else {
        for (String neighbor in graph[currentNode]!) {
          if (!currentPath.contains(neighbor)) {
            List<String> newPath = List.from(currentPath);
            newPath.add(neighbor);
            queue.add(newPath);
          }
        }
      }
    }

    return paths;
  }

  // b. Get the shortest path between A-H
  int getShortestPathLength(String start, String end) {
    Queue<List<String>> queue = Queue();
    Set<String> visited = {start};
    queue.add([start]);
    int steps = 0;

    while (queue.isNotEmpty) {
      int queueSize = queue.length;
      for (int i = 0; i < queueSize; i++) {
        List<String> currentPath = queue.removeFirst();
        String currentNode = currentPath.last;

        if (currentNode == end) {
          return steps;
        }

        for (String neighbor in graph[currentNode]!) {
          if (!visited.contains(neighbor)) {
            visited.add(neighbor);
            List<String> newPath = List.from(currentPath);
            newPath.add(neighbor);
            queue.add(newPath);
          }
        }
      }
      steps++;
    }

    return -1; // No path found
  }

  // a. Print all possible paths between A-H
  List<List<String>> allPaths = getAllPaths('A', 'H');
  print('All possible paths between A-H:');
  for (List<String> path in allPaths) {
    print(path.join(' -> '));
  }
  print('\nTotal path count: ${allPaths.length}');

  // b. Print the shortest path length between A-H
  int shortestPathLength = getShortestPathLength('A', 'H');
  print('\nShortest path length between A-H: $shortestPathLength');
}

```

View answer:
https://dartpad.dev/?id=a755edc35eac5400be9bb3c498343cda
