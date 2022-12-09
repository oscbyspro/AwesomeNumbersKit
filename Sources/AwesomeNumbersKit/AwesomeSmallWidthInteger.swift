//*============================================================================*
// MARK: * Awesome Small Width Integer
//*============================================================================*

/// An AwesomeFixedWidthInteger with trivial implementation.
///
/// - Int
/// - Int64
/// - UInt
/// - UInt64
///
public protocol AwesomeSmallWidthInteger: AwesomeFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension AwesomeSmallWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ bit: Bool) {
        self = bit ?  1 : 0
    }
    
    @inlinable public init(repeating bit: Bool) {
        self = bit ? ~0 : 0
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var isZero: Bool {
        self == 0
    }
    
    @inlinable public var isLessThanZero: Bool {
        Self.isSigned ? self < 0 : false
    }
    
    @inlinable public var mostSignificantBit: Bool {
        self & 1 << (Self.bitWidth - 1) != 0
    }
    
    @inlinable public var leastSignificantBit: Bool {
        self & 1 != 0
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let o: Bool; (self, o) = self.addingReportingOverflow(amount); return o
    }
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let o: Bool; (self, o) = self.subtractingReportingOverflow(amount); return o
    }
    
    @inlinable public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflow(by: amount); return o
    }
}

//*============================================================================*
// MARK: * Awesome Small Width Integer x Swift
//*============================================================================*

extension Int:    AwesomeSmallWidthInteger { }
extension Int64:  AwesomeSmallWidthInteger { }
extension UInt:   AwesomeSmallWidthInteger { }
extension UInt64: AwesomeSmallWidthInteger { }
