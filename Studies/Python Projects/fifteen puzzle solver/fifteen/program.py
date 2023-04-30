import solvers as s
import logic as l
import sys


def findNth(haystack, needle, n):
    start = haystack.find(needle)
    while start >= 0 and n > 1:
        start = haystack.find(needle, start+len(needle))
        n -= 1
    return start


def readPuzzle(fileName):
    file = open(fileName, 'r')
    size = file.readline()
    width = int(size[0])
    height = int(size[2])
    start = 0
    puzzle = []
    for _ in range(0, height):
        row = []
        rowString = file.readline()
        for i in range(0, width):
            end = findNth(rowString, ' ', i + 1)
            number = int(rowString[start:end])
            row.append(number)
            start = end + 1
        puzzle.append(row)
    return puzzle


def writeSolution(fileName, length, solution):
    file = open(fileName, 'w')
    file.write(str(length))
    file.write('\n')
    if solution is not None:
        file.write(solution)


def writeStatistics(fileName, solLen, seenLen, comp, maxDep, elap):
    file = open(fileName, 'w')
    file.write(str(solLen))
    file.write('\n')
    file.write(str(seenLen))
    file.write('\n')
    file.write(str(comp))
    file.write('\n')
    file.write(str(maxDep))
    file.write('\n')
    file.write(str(elap))


if __name__ == '__main__':
    strategy = sys.argv[1]
    param = sys.argv[2]
    puzzleFile = sys.argv[3]
    solFile = sys.argv[4]
    statFile = sys.argv[5]

    board = readPuzzle("puzzles/" + puzzleFile)
    puzzle = l.Puzzle(board)
    # puzzle = puzzle.shuffle()
    s = s.Solver(puzzle)

    match strategy:
        case "bfs":
            p, solLength, seenLen, computed, maxDepth, elapsed = s.bfs(param)
        case "dfs":
            p, solLength, seen, seenLen, computed, maxDepth, elapsed = s.dfs(param, s.start)
        case "astr":
            p, solLength, seenLen, computed, maxDepth, elapsed = s.astr(param)
        case _:
            p = "Not implemented algorithm"
            solLength = "Not implemented algorithm"
            seenLen = "Not implemented algorithm"
            computed = "Not implemented algorithm"
            maxDepth = "Not implemented algorithm"
            elapsed = "Not implemented algorithm"

    solName = "solutions/" + strategy + "/" + param + "/" + solFile
    statName = "statistics/" + strategy + "/" + param + "/" + statFile

    writeSolution(solName, solLength, p)
    writeStatistics(statName, solLength, seenLen, computed, maxDepth, elapsed)

    # print("Solution Length:   ", solLength)
    # print("Solution       :   ", p)
    # print("Seen Nodes     :   ", seenLen)
    # print("Computed Nodes :   ", computed)
    # print("Maximum Depth  :   ", maxDepth)
    # print("Elapsed Time   :   ", elapsed, " ms.")

    # steps = 0
    # for node in p:
    #     print(node.action)
    #     node.puzzle.pprint()
    #     steps += 1
    #
    # print("Total number of steps: " + str(steps))
