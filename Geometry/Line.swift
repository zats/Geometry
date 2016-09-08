import Foundation
import CoreGraphics

/// Enum representing infinite line
///
/// - regular:  Line represented by an equasion *y = mx + b*
/// - vertical: Vertical line represented by an equasion *x = k*
public enum Line {
    case regular(m: CGFloat, b: CGFloat)
    case vertical(x: CGFloat)
}

public extension Line {
    /// Creates an infinite line matching angle of the passed line segment
    ///
    /// - parameter lineSegment: line segment to base line on
    public init(lineSegment: LineSegment) {
        let m = (lineSegment.b.y - lineSegment.a.y) / (lineSegment.b.x - lineSegment.a.x)
        if m.isFinite  {
            let b = lineSegment.a.y - m * lineSegment.a.x
            self = .regular(m: m, b: b)
        } else {
            self = .vertical(x: lineSegment.a.x)
        }
    }
}

public extension Line {
    /// Angle of the line
    public var angle: CGFloat {
        switch self {
        case let .regular(m, _):
            return atan(m)
        case .vertical:
            return .pi / 2
        }
    }
}

public extension Line {
    /// Returns an intersection with another line if exists
    ///
    /// - parameter other: Another line to intersect with line
    public func intersection(with other: Line) -> Point? {
        switch (self, other) {
        case let (.vertical(x1), .vertical(x2)):
            if x1 != x2 {
                return nil
            } else {
                assertionFailure("It's the same line, returning an arbitrary point")
                return Point(x: 0, y: x1)
            }
        case let (.vertical(x), .regular(m, b)):
            return Point(x: x, y: m * x + b)
        case let (.regular(m, b), .vertical(x)):
            return Point(x: x, y: m * x + b)
        case let (.regular(m1, b1), .regular(m2, b2)):
            let x = (b2 - b1) / (m1 - m2)
            if x.isInfinite {
                return nil
            } else {
                let y = m1 * x + b1
                return Point(x: x, y: y)
            }
        }
    }
    
    /// Returns whether a line contains a specified point.
    ///
    /// - parameter point: The point to examine
    public func contains(_ point: Point) -> Bool {
        switch self {
        case let .vertical(x):
            return point.x == x
        case let .regular(m, b):
            return point.y == m * point.x + b
        }
    }

    /// Calculates a distance between a receiver and specified point.
    ///
    /// - parameter point: A point to measure distance to
    public func distance(to point: Point) -> CGFloat {
        switch self {
        case let .vertical(x):
            return Point(x: x, y: point.y).distance(to: point)
        case let .regular(m, b):
            return abs(m * point.x - point.y + b) / sqrt(m * m + 1)
        }
    }
}
