import CoreGraphics
import UIKit

/// Structure representing a polygon with an arbitrary number of vertices
public struct Polygon {
    public var vertices: [Point]

    /// Setting edges that a not consecutively connected will trigger a precondition failure
    public var edges: [LineSegment] {
        get {
            return vertices.enumerated().map { offset, vertex in
                LineSegment(a: vertex, b: vertices[(offset + 1) % vertices.count])
            }
        }
        set {
            edges.enumeratedPairs().forEach { (_, edge1, _, edge2) in
                precondition(edge1.b == edge2.a)
            }
            vertices = edges.map { $0.a }
        }
    }

    public init(vertices: [Point]) {
        self.vertices = vertices
    }

    /// Initializing with edges that a not consecutively connected will trigger a precondition failure
    public init(edges: [LineSegment]) {
        edges.enumeratedPairs().forEach { (_, edge1, _, edge2) in
            precondition(edge1.b == edge2.a)
        }
        self.init(vertices: edges.map { $0.a })
    }
}

public extension Polygon {
    public init(rect: CGRect) {
        self.init(vertices: [
            Point(x: rect.minX, y: rect.minY),
            Point(x: rect.minX, y: rect.maxY),
            Point(x: rect.maxX, y: rect.maxY),
            Point(x: rect.maxX, y: rect.minY)
            ])
    }

    public var frame: CGRect {
        return CGRect(spaningOver: vertices)
    }
    
    public var bounds: CGRect {
        return CGRect(origin: .zero, size: frame.size)
    }
    
    public var center: Point {
        return frame.center
    }
}

public extension Polygon {
    /// Returns an array of points where polygon will intersect with a specified line segment or an empty array if line segment doesn't intersect polygon
    public func intersection(with lineSegment: LineSegment) -> [Point] {
        return edges.flatMap {
            $0.intersection(with: lineSegment)
        }
    }

    /// Returns an array of points where polygon will intersect with a specified line or an empty array if line doesn't intersect polygon
    public func intersection(with line: Line) -> [Point] {
        return edges.flatMap { edge in
            Line(lineSegment: edge).intersection(with: line)
                .flatMap { point in
                    edge.contains(point) ? point : nil
                }
        }
    }
}

public extension Polygon {
    public func applying(_ matrix: CGAffineTransform) -> Polygon {
        return Polygon(vertices: vertices.map {
            $0.applying(matrix)
        })
    }
}

public extension Polygon {
    public func inset(with insets: UIEdgeInsets) -> Polygon? {
        let insets = [insets.left, insets.bottom, insets.right, insets.top]
        let vertices = zip(edges, insets)
            .map { edge, inset in
                edge.translated(by: inset)
            }.map {
                Line(lineSegment: $0)
            }.enumeratedPairs().flatMap { _, line1, _, line2 in
                line1.intersection(with: line2)
            }
        guard vertices.count == 4 else {
            return nil
        }
        return Polygon(vertices: vertices)
    }
}

public extension Polygon {
    public func map(_ transform: (Point) throws -> Point) rethrows -> Polygon {
        return try Polygon(vertices: vertices.map(transform))
    }
}

extension Polygon: Equatable {
}

public func == (lhs: Polygon, rhs: Polygon) -> Bool {
    return lhs.vertices == rhs.vertices
}
