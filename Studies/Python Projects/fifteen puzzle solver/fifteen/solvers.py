import collections
import logic as l
import time


class Solver:
    """
    An 'x*y-puzzle' solver
    - 'start' is a Puzzle instance
    """
    def __init__(self, start):
        self.start = start

    def getStart(self):
        return self.start

    def astr(self, metric, allowedDepth=25):
        """
        Perform best first search (A*) and return a path
        to the solution, if it exists
        """
        begin = time.time()
        queue = collections.deque([l.Node(self.start, None, None, metric)])
        seen = set()
        seen.add(queue[0].state)
        computed = 0
        maxDepth = 0
        while queue:
            queue = collections.deque(sorted(list(queue), key=lambda node: node.f))
            node = queue.popleft()
            computed += 1
            if maxDepth < node.g:
                maxDepth = node.g
            if node.solved:
                end = time.time()
                path = self.pathToString(node.path)
                return path, len(path), len(seen), computed, maxDepth, format((end - begin) * 1000, '.3f')
            elif maxDepth > allowedDepth:
                end = time.time()
                return None, -1, len(seen), computed, maxDepth, format((end - begin) * 1000, '.3f')
            for move, action in node.actions:
                child = l.Node(move(), node, action)

                if child.state not in seen:
                    queue.appendleft(child)
                    seen.add(child.state)

    def bfs(self, order, allowedDepth=25):
        """
        Perform breadth first search and return a path
        to the solution, if it exists
        """
        begin = time.time()
        queue = collections.deque([l.Node(self.start, None, None, order)])
        seen = set()
        seen.add(queue[0].state)
        computed = 0
        depth = 0
        nthLevel = []
        while queue:
            node = queue.popleft()
            computed += 1
            if node.solved:
                end = time.time()
                path = self.pathToString(node.path)
                return path, len(path), len(seen), computed, depth, format((end - begin) * 1000, '.3f')
            if depth < allowedDepth:
                for move, action in node.actions:
                    child = l.Node(move(), node, action, order)
                    if child.state not in seen:
                        nthLevel.append(child)
                        seen.add(child.state)
            if len(queue) == 0 and len(nthLevel) > 0:
                depth += 1
                nthLevel = self.sortChildren(nthLevel, order)
                for element in nthLevel:
                    queue.appendleft(element)
                nthLevel = []
            elif len(queue) == 0 and len(nthLevel) == 0:
                end = time.time()
                return None, -1, len(seen), computed, depth, format((end - begin) * 1000, '.3f')

    def dfs(self, order, startPuzzle, parent=None, action=None, seen=None, begin=time.time(), computed=0,
            depth=0, maxDepth=0, allowedDepth=20):
        """
        Perform deap first search and return a path
        to the solution, if it exists
        """
        if maxDepth < depth:
            maxDepth = depth
        if seen is None:
            seen = set()
        queue = collections.deque([l.Node(startPuzzle, parent, action, order)])
        childQueue = collections.deque([])
        if parent is None:
            seen.add(queue[0].state)
        node = queue.popleft()
        computed += 1
        if node.solved:
            end = time.time()
            path = self.pathToString(node.path)
            return path, len(path), seen, len(seen), computed, maxDepth, format((end - begin) * 1000, '.3f')
        for move, action in node.actions:
            child = l.Node(move(), node, action, order)
            #if child.state not in seen:
            childQueue.appendleft(child)
            seen.add(child.state)
        childQueue = collections.deque(self.sortChildren(list(childQueue), order))
        while childQueue:
            next = childQueue.popleft()
            if depth < allowedDepth:
                sol, solLen, seen, seenLen, computed, maxDepth, elapsed = \
                    self.dfs(order, next.puzzle, next.parent, next.action, seen, begin, computed, depth + 1, maxDepth)
                if solLen != -1:
                    return sol, solLen, seen, seenLen, computed, maxDepth, elapsed
        end = time.time()
        return None, -1, seen, len(seen), computed, maxDepth, format((end - begin) * 1000, '.3f')




    def sortChildren(self, children, order):
        count = 0
        dict = {}
        for letter in order:
            dict[letter] = count
            count += 1
        for child in children:
            child.action = dict[child.action]
        children = sorted(children, key=lambda child: child.action)
        for child in children:
            child.action = list(dict.keys())[list(dict.values()).index(child.action)]
        return children

    def pathToString(self, path):
        solution = ""
        canAdd = False
        for n in path:
            if canAdd:
                solution += n.action
            canAdd = True
        return solution

