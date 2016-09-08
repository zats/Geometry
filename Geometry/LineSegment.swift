import CoreGraphics


/// A structure that contains two points denoting respective ends of the line segment.
public struct LineSegment {
    public var a: Point
    public var b: Point

    public init(a: CGPoint, b: CGPoint) {
        self.a = a
        self.b = b
    }
}

public extension LineSegment {
    /// Lengths of the line segment. Distance between both ends of the line segment.
    public var length: CGFloat {
        return a.distance(to: b)
    }

    /// Angle between to ends of the beginning and end of line segment
    public var angle: CGFloat {
        return (a - b).angle
    }
    
    /// Returns a `CGRect` enclosing line segment.
    public var bounds: CGRect {
        let delta = a - b
        return CGRect(x: min(a.x, b.x), y: min(a.y, b.y), width: abs(delta.x), height: abs(delta.y))
    }
}

public extension LineSegment {
    /// Returns an intersection with another line segment if exists
    ///
    /// - parameter other: Another line segment to intersect with line segment
    public func intersection(with other: LineSegment) -> CGPoint? {
        let delta2 = other.b - other.a
        let delta1 = b - a
        let d = delta2.y * delta1.x - delta2.x * delta1.y
        if d == 0 {
            return nil
        }
        let delta3 = a - other.a
        let u0 = delta2.x * delta3.y - delta2.y * delta3.x / d
        let u1 = delta1.x * delta3.y - delta1.y * delta3.x / d
        if u0 < 0 || u0 > 1 || u1 < 0 || u1 > 0 {
            return nil
        }
        return CGPoint(x: a.x + u0 * delta3.x, y: a.y + u0 * delta3.y)
    }

    /// Calculates a distance between a receiver and specified point.
    ///
    /// - parameter point: A point to measure distance to
    public func distance(to point: Point) -> CGFloat {
        return ((b - a) ⨯ point + a ⨯ b) / length
    }

    /// Returns whether a line segment contains a specified point.
    ///
    /// - parameter point: The point to examine
    public func contains(_ point: Point) -> Bool {
        return a.distance(to: point) + b.distance(to: point) == a.distance(to: b)
    }
}

public extension LineSegment {
    /// Returns a line segment translated by specified distance keeping original angle.
    /// Translation happens in a direction perpendicular to the current angle of the line.
    ///
    /// - parameter distance: amount to translate the line by
    public func translated(by distance: CGFloat) -> LineSegment {
        let vector = Point(angle: self.angle - .pi / 2, distance: distance)
        return LineSegment(a: a + vector, b: b + vector)
    }
}
