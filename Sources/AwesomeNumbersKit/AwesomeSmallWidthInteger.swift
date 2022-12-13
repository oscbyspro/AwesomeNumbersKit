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
        Self.isSigned &&  self < 0
    }
    
    @inlinable public var mostSignificantBit: Bool {
        self & 1 << (Self.bitWidth - 1) != 0
    }
    
    @inlinable public var leastSignificantBit: Bool {
        self & 1 != 0
    }
    
    @inlinable public var mostSignificantWord: UInt {
        words.last  ?? UInt()
    }
    
    @inlinable public var leastSignificantWord: UInt {
        words.first ?? UInt()
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
// MARK: * Awesome Small Width Integer x Signed
//*============================================================================*

extension AwesomeSmallWidthInteger where Self: AwesomeSignedFixedWidthInteger {
    
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
// MARK: * Awesome Small Width Integer x Swift
//*============================================================================*

extension Int:    AwesomeSmallWidthInteger, AwesomeSignedFixedWidthInteger   { }
extension Int64:  AwesomeSmallWidthInteger, AwesomeSignedFixedWidthInteger   { }
extension UInt:   AwesomeSmallWidthInteger, AwesomeUnsignedFixedWidthInteger { }
extension UInt64: AwesomeSmallWidthInteger, AwesomeUnsignedFixedWidthInteger { }
