// Playground - noun: a place where people can play

import Cocoa


enum PointState
{
    case White,Black,Free
    
    func desc() -> String
    {
        switch self
        {
        case .White:
            return "White";
        case .Black:
            return "Black";
        case .Free:
            return "Free";
        }
        
    }
    
}

enum SquareType
{
    case Outer,Mid,Inner
}

class Point
{
    var State : PointState
    let value : Int
    
    init(val: Int)
    {
        self.value = val
        self.State = PointState.Free
    }
    
    func desc() -> String
    {
        return "\(self.value), \(self.State.desc())"
    }
}



class Board
{
    let board : [Point] = [Point]()
    
    init()
    {
        for  i in 0...24
        {
            board.append(Point(val: i))
        }
    }
    
    func desc() -> String
    {
        var str = ""
        for item in board
        {
            str += item.desc() + "\n"
        }
        return str
        
    }
    
}

class Game
{
    let mill = [(0,0,0),(1,2,3),(3,4,5),(5,6,7),(7,8,1),(9,10,11),(11,12,13),(13,14,15),(15,16,9),(17,18,19),(19,20,21),(21,22,23),(23,24,17),
        (2,10,18),(4,12,20),(6,14,22),(8,16,24)]
    
    let moves = [[],[2,8],[1,3,10],[2,4],[3,5,12],[4,6],[5,7,14],[6,8],[7,1,16],[10,16],[9,11,2,18],[10,12],[11,13,4,20],[12,14],
        [13,15,6,22],[14,16],[15,9,8,24],[18,24],[17,19,10],[18,20],[19,21,12],[20,22],[21,23,14],[22,24],[23,17,16]]
    let board : Board
    
    var moveCounter: Int = 0
    
    init()
    {
        board = Board()
    }
    
    func AddWhitePiece(p: Int) -> Bool
    {
        return AddPieceAt(p, withColor: PointState.White)
    }
    
    func AddBlackPiece(p: Int) -> Bool
    {
        return AddPieceAt(p, withColor: PointState.Black)
    }
    
    
    func AddPieceAt (point: Int , withColor : PointState) -> Bool
    {
        if(self.board.board[point].State != PointState.Free)
        {
            return false
        }
        else
        {
            moveCounter++
            self.board.board[point].State = withColor
            return true
        }
    }
    
    func CheckTurn() -> PointState
    {
        if(moveCounter % 2 == 0)
        {
            return PointState.White
        }
        else
        {
            return PointState.Black
        }
    }
    
    func RemoveAt(point: Int)
    {
        if(self.board.board[point].State == CheckTurn())
        {
            self.board.board[point].State = PointState.Free
        }
    }
    
    func StatusAt(point: Int) -> PointState
    {
        return self.board.board[point].State
    }
    
    func CheckMill(point: Int) -> Bool
    {
        for millSet in mill.filter({$0.0 == point || $0.1 == point || $0.2 == point})
        {
            if(self.board.board[millSet.0].State == self.board.board[millSet.1].State &&  self.board.board[millSet.2].State == self.board.board[millSet.0].State && self.board.board[millSet.0].State != PointState.Free)
            {
                return true
            }
        }
        return false
    }
    
    func MoveFrom(current: Int, toNext: Int) -> (Bool,Bool)
    {
        if(self.board.board[current].State == PointState.Free)
        {
            return (false,false);
        }
        if(!contains(moves[current],toNext))
        {
            return (false,false);
        }
        if(self.board.board[toNext].State !=  PointState.Free)
        {
            return (false,false);
        }
        if(self.board.board[current].State != CheckTurn())
        {
            return (false,false)
        }
        //Legal move
        self.board.board[toNext].State =  self.board.board[current].State
        self.board.board[current].State = PointState.Free
        moveCounter++
        return (true,CheckMill(toNext))
        
    }
    
}


























