//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Trivial
//*============================================================================*

/// An awesome fixed-width integer with trivial implementation.
///
/// - `Int`
/// - `Int8`
/// - `Int16`
/// - `Int32`
/// - `Int64`
/// - `UInt`
/// - `UInt8`
/// - `UInt16`
/// - `UInt32`
/// - `UInt64`
///
public protocol AwesomeTrivialFixedWidthInteger: AwesomeFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension AwesomeTrivialFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bit: Bool) {
        self = bit ?  (1 as Self) : (0 as Self)
    }
    
    @_transparent public init(repeating bit: Bool) {
        self = bit ? ~(0 as Self) : (0 as Self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var isZero: Bool {
        self == (0 as Self)
    }
    
    @_transparent public var isLessThanZero: Bool {
        Self.isSigned && self < (0 as Self)
    }
    
    @_transparent public var mostSignificantBit: Bool {
        self & (1 as Self) << (Self.bitWidth - 1) != (0 as Self)
    }
    
    @_transparent public var leastSignificantBit: Bool {
        self & (1 as Self) != (0 as Self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let pvo: PVO<Self> = self.addingReportingOverflow(amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let pvo: PVO<Self> = self.subtractingReportingOverflow(amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func divideReportingOverflow(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let hl: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(truncatingIfNeeded: hl.low); return hl.high
    }
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Signed x Trivial
//*============================================================================*

extension AwesomeTrivialFixedWidthInteger where Self: AwesomeSignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func negateReportingOverflow() -> Bool {
        let pvo: PVO<Self> = self.negatedReportingOverflow()
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public func negatedReportingOverflow() -> PVO<Self> {
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
