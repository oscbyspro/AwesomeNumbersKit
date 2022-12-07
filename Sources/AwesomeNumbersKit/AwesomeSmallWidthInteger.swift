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
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var isZero: Bool {
        self == 0
    }
    
    @inlinable public var isLessThanZero: Bool {
        Self.isSigned ? self < 0 : false
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let overflow: Bool; (self, overflow) = self.addingReportingOverflow(amount); return overflow
    }
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let overflow: Bool; (self, overflow) = self.subtractingReportingOverflow(amount); return overflow
    }
}

//*============================================================================*
// MARK: * Awesome Small Width Integer x Swift
//*============================================================================*

extension Int:    AwesomeSmallWidthInteger { }
extension Int64:  AwesomeSmallWidthInteger { }
extension UInt:   AwesomeSmallWidthInteger { }
extension UInt64: AwesomeSmallWidthInteger { }
