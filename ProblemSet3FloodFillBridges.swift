import Foundation

func ProblemSet3FloodFillBridges() {

    // Get inputs and pre-processing.
    let n = Int(readLine()!)!
    var map = [[Int]]()
    var coloredMap = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        map.append(row)
    }

    func isWithinBounds(_ x: Int, _ y: Int) -> Bool {
        return x >= 0 && x < n && y >= 0 && y < n
    }
    
    let dx = [0, 0, 1, -1]
    let dy = [1, -1, 0, 0]

    func bfs(x: Int, y: Int, id: Int) {

        struct Square {
            let x: Int
            let y: Int
        }

        let q = Queue<Square>()
        q.enqueue(item: Square(x: x, y: y))
        coloredMap[x][y] = id

        while !q.isEmpty() {
            let square = q.dequeue()
            let x = square!.x
            let y = square!.y

            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                
                if isWithinBounds(nx, ny) {
                    if map[nx][ny] == 1 && coloredMap[nx][ny] == 0 {
                        q.enqueue(item: Square(x: nx, y: ny))
                        coloredMap[nx][ny] = id
                    }
                }
            }
        }
    }



    var id = 0
    for x in 0..<n {
        for y in 0..<n {
            if map[x][y] == 1 && coloredMap[x][y] == 0 {
                id += 1
                bfs(x: x, y: y, id: id)
            }
        }
    }
    
    func distanceToNearestLand(x: Int, y: Int, id: Int, counter: Int, _ distanceMap: inout [[Int]]) {
        distanceMap[x][y] = counter
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            if isWithinBounds(nx, ny) && coloredMap[nx][ny] != id && distanceMap[nx][ny] > counter {
                if coloredMap[nx][ny] != id && coloredMap[nx][ny] > 0 {
                    minDistance = min(minDistance, counter)
                }
                distanceToNearestLand(x: nx, y: ny, id: id, counter: counter + 1, &distanceMap)
            }
        }
        
    }
    
    var minDistance = n * n
    let totalIds = id
    for id in 1...totalIds {
        for y in 0..<n {
            for x in 0..<n {
                if coloredMap[x][y] == id {
                    var distanceMap = [[Int]](repeating: [Int](repeating: n * n, count: n), count: n)
                    distanceToNearestLand(x: x, y: y, id: id, counter: 0, &distanceMap)
                }
            }
        }
    }
    
    print(minDistance)
}
