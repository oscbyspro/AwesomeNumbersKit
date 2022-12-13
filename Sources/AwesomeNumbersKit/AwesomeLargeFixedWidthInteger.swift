//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large
//*============================================================================*

public protocol AwesomeLargeFixedWidthInteger: AwesomeFixedWidthInteger where
Magnitude: AwesomeUnsignedLargeFixedWidthInteger {
    
    associatedtype Small: AwesomeSmallFixedWidthInteger // TODO: AwesomeIntOrUInt
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(repeating word: UInt)
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Small, at index: Int) -> Bool
    
    @inlinable func addingReportingOverflow(_ amount: Small, at index: Int) -> PVO<Self>
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Small, at index: Int) -> Bool
    
    @inlinable func subtractingReportingOverflow(_ amount: Small, at index: Int) -> PVO<Self>
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Signed
//*============================================================================*

public protocol AwesomeSignedLargeFixedWidthInteger: AwesomeLargeFixedWidthInteger,
AwesomeSignedFixedWidthInteger where Small == Int { }

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedLargeFixedWidthInteger: AwesomeLargeFixedWidthInteger,
AwesomeUnsignedFixedWidthInteger where Small == UInt { }

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Addition
//*============================================================================*

extension AwesomeLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func add(_ amount: Small, at index: Int) {
        let o = self.addReportingOverflow(amount, at: index); precondition(!o)
    }
    
    @inlinable public func adding(_ amount: Small, at index: Int) -> Self {
        let (pv, o) = self.addingReportingOverflow(amount, at: index); precondition(!o); return pv
    }
    
    @inlinable public mutating func addWrappingAround(_ amount: Small, at index: Int) {
        let _ = self.addReportingOverflow(amount, at: index)
    }
    
    @inlinable public func addingWrappingAround(_ amount: Small, at index: Int) -> Self {
        let (pv, _) = self.addingReportingOverflow(amount, at: index); return pv
    }
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Addition
//*============================================================================*

extension AwesomeLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtract(_ amount: Small, at index: Int) {
        let o = self.subtractReportingOverflow(amount, at: index); precondition(!o)
    }
    
    @inlinable public func subtracting(_ amount: Small, at index: Int) -> Self {
        let (pv, o) = self.subtractingReportingOverflow(amount, at: index); precondition(!o); return pv
    }
    
    @inlinable public mutating func subtractWrappingAround(_ amount: Small, at index: Int) {
        let _ = self.subtractReportingOverflow(amount, at: index)
    }
    
    @inlinable public func subtractingWrappingAround(_ amount: Small, at index: Int) -> Self {
        let (pv, _) = self.subtractingReportingOverflow(amount, at: index); return pv
    }
}
