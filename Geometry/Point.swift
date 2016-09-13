import CoreGraphics

public typealias Point = CGPoint

public extension Point {
    public static prefix func - (lhs: Point) -> Point {
        return Point(x: -lhs.x, y: -lhs.y)
    }
    
    public static func - (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    public static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func -= (lhs: inout Point, rhs: Point) {
        lhs = lhs - rhs
    }

    public static func += (lhs: inout Point, rhs: Point)  {
        lhs = lhs + rhs
    }

    public static func * (lhs: Point, rhs: CGFloat) -> Point {
        return Point(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    public static func * (lhs: CGFloat, rhs: Point) -> Point {
        return Point(x: rhs.x * lhs, y: rhs.y * lhs)
    }

    public static func / (lhs: Point, rhs: CGFloat) -> Point {
        return Point(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

public extension Point {
    /// Constructs a point at a specified `distance` and `angle` from the `origin`
    public init(angle: CGFloat, distance: CGFloat, origin: CGPoint = .zero) {
        self.init(
            x: origin.x + cos(angle) * distance,
            y: origin.y + sin(angle) * distance
        )
    }
    
    /// Distance of the point from the origin (0, 0)
    var distance: CGFloat {
        return sqrt(x * x + y * y)
    }
    
    /// Angle of the line connecting origin with this point
    var angle: CGFloat {
        return atan2(y, x)
    }
}

public extension Point {
    /// Returns a rectangle encapsulating circle with given radius around this point
    public func boundsForEllipseWithRadius(_ radius: CGFloat) -> CGRect {
        return CGRect(x: self.x - radius, y: self.y - radius, width: radius * 2, height: radius * 2)
    }
}

infix operator ⨯: MultiplicationPrecedence

public extension Point {
    public static func ⨯ (lhs: Point, rhs: Point) -> CGFloat {
        return lhs.crossProduct(with: rhs)
    }
    
    private func crossProduct(with point: Point) -> CGFloat {
        return x * point.y - y * point.x
    }

    /// Returns a distance from this point to a specified point
    ///
    /// - parameter point: Point to inspect
    public func distance(to point: Point) -> CGFloat {
        let delta = self - point
        return sqrt(delta.x * delta.x + delta.y * delta.y)
    }    
}

