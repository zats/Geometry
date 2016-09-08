import CoreGraphics


public extension CGSize {
    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    public static func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
        return rhs * lhs
    }
}
