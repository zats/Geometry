import CoreGraphics


public extension CGSize {
    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    public static func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
        return rhs * lhs
    }
    
    public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }

    public static func / (rhs: CGFloat, lhs: CGSize) -> CGSize {
        return lhs / rhs
    }
    
    public static prefix func - (lhs: CGSize) -> CGSize {
        return CGSize(width: -lhs.width, height: -lhs.height)
    }
    
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}

public extension CGSize {
    public var cgPoint: CGPoint {
        return CGPoint(x: width, y: height)
    }
}
