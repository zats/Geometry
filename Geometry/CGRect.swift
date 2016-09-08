import CoreGraphics


public extension CGRect {
    /// Returns a minimum rectangle that encloses all passed points
    public init(spaningOver corners: [CGPoint]) {
        let minX = corners.reduce(CGFloat.greatestFiniteMagnitude) { $0 > $1.x ? $1.x : $0 }
        let minY = corners.reduce(CGFloat.greatestFiniteMagnitude) { $0 > $1.y ? $1.y : $0 }
        let maxX = corners.reduce(CGFloat.leastNormalMagnitude) { $0 < $1.x ? $1.x : $0 }
        let maxY = corners.reduce(CGFloat.leastNormalMagnitude) { $0 < $1.y ? $1.y : $0 }
        self.init(
            x: minX,
            y: minY,
            width: maxX - minX,
            height: maxY - minY)
    }
}

// MARK: - Convenience

public extension CGRect {
    public var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }

    public var topLeft: CGPoint {
        return CGPoint(x: minX, y: minY)
    }

    public var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }

    public var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }

    public var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
}
