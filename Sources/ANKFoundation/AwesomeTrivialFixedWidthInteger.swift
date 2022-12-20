//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Trivial
//*============================================================================*

/// An awesome fixed-width integer with trivial implementation.
///
/// - Int
/// - Int8
/// - Int16
/// - Int32
/// - Int64
/// - UInt
/// - UInt8
/// - UInt16
/// - UInt32
/// - UInt64
///
public protocol AwesomeTrivialFixedWidthInteger: AwesomeFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension AwesomeTrivialFixedWidthInteger {
    
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
        Self.isSigned &&  self < 0
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
    
    @inlinable public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.dividedReportingOverflow(by: divisor); return o
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.remainderReportingOverflow(dividingBy: divisor); return o
    }
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let (h, l) = multipliedFullWidth(by: amount); self = Self(truncatingIfNeeded: l); return h
    }
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Signed x Trivial
//*============================================================================*

extension AwesomeTrivialFixedWidthInteger where Self: AwesomeSignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func negateReportingOverflow() -> Bool {
        let o: Bool; (self, o) = self.negatedReportingOverflow(); return o
    }
    
    @inlinable public func negatedReportingOverflow() -> PVO<Self> {
        PVO(~self &+ 1, self == Self.min)
    }
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Small x Swift
//*============================================================================*

extension Int:    AwesomeTrivialFixedWidthInteger,   AwesomeSignedFixedWidthInteger { }
extension Int8:   AwesomeTrivialFixedWidthInteger,   AwesomeSignedFixedWidthInteger { }
extension Int16:  AwesomeTrivialFixedWidthInteger,   AwesomeSignedFixedWidthInteger { }
extension Int32:  AwesomeTrivialFixedWidthInteger,   AwesomeSignedFixedWidthInteger { }
extension Int64:  AwesomeTrivialFixedWidthInteger,   AwesomeSignedFixedWidthInteger { }
extension UInt:   AwesomeTrivialFixedWidthInteger, AwesomeUnsignedFixedWidthInteger { }
extension UInt8:  AwesomeTrivialFixedWidthInteger, AwesomeUnsignedFixedWidthInteger { }
extension UInt16: AwesomeTrivialFixedWidthInteger, AwesomeUnsignedFixedWidthInteger { }
extension UInt32: AwesomeTrivialFixedWidthInteger, AwesomeUnsignedFixedWidthInteger { }
extension UInt64: AwesomeTrivialFixedWidthInteger, AwesomeUnsignedFixedWidthInteger { }
