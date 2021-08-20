import Foundation

func ProblemSet3FloodFillTomatoFarm() {
    
    func isWithinBounds(_ x: Int, _ y: Int) -> Bool {
        return x >= 0 && x < m && y >= 0 && y < n
    }
    
    func shouldEvaluate(_ x: Int, _ y: Int, _ nextCounter: Int) -> Bool {
        if map[y][x] != 1 && map[y][x] != -1 && map[y][x] >= nextCounter {
            return true
        }
        return false
    }
    
    func dfs(x: Int, y: Int, counter: Int) {
        map[y][x] = min(counter, map[y][x])
        
        let dx = [0, 0, 1, -1]
        let dy = [1, -1, 0, 0]

        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if isWithinBounds(nx, ny) && shouldEvaluate(nx, ny, counter + 1) {
                dfs(x: nx, y: ny, counter: counter + 1)
            }
        }
    }
    
    // Get inputs and pre-processing.
    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
    let m = firstLine[0]
    let n = firstLine[1]
    
    var map = [[Int]]()
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map
        { Int($0)! }.map
        { $0 == 0 ? 999_999 : $0 }
        map.append(row)
    }
    
    // Get days map for each 1.
    for y in 0..<n {
        for x in 0..<m {
            if map[y][x] == 1 {
                dfs(x: x, y: y, counter: 1)
            }
        }
    }
    
    // Post-processing.
    let day = map.reduce(0, { max($0, $1.reduce(0, { max($0,$1) })) }) - 1
    if day > m * n {
        print(-1)
    } else {
        print(day)
    }
    
}
