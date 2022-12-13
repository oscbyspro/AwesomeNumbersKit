//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Subtraction
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Self) {
        lhs.body -= rhs.body
    }
    
    @inlinable public static func -(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body - rhs.body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        self.body.subtractReportingOverflow(amount.body)
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        let (pv, o) = self.body.subtractingReportingOverflow(amount.body); return (Self(bitPattern: pv), o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Signed x Subtraction
//*============================================================================*

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Int) {
        lhs.subtract(rhs)
    }
    
    @inlinable public static func -(lhs: Self, rhs: Int) -> Self {
        lhs.subtracting(rhs)
    }
    
    @inlinable public static func &-=(lhs: inout Self, rhs: Int) {
        lhs.subtractWrappingAround(rhs)
    }
    
    @inlinable public static func &-(lhs: Self, rhs: Int) -> Self {
        lhs.subtractingWrappingAround(rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtract(_ amount: Int, at index: Int = 0) {
        self.body.subtract(amount, at: index)
    }
    
    @inlinable public func subtracting(_ amount: Int, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.subtracting(amount, at: index))
    }
    
    @inlinable public mutating func subtractWrappingAround(_ amount: Int, at index: Int = 0) {
        self.body.subtractWrappingAround(amount, at: index)
    }
    
    @inlinable public func subtractingWrappingAround(_ amount: Int, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.subtractingWrappingAround(amount))
    }
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Int, at index: Int = 0) -> Bool {
        self.body.subtractReportingOverflow(amount, at: index)
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Int, at index: Int = 0) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, at: index); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Unsigned x Subtraction
//*============================================================================*

extension OBEUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: UInt) {
        lhs.subtract(rhs)
    }
    
    @inlinable public static func -(lhs: Self, rhs: UInt) -> Self {
        lhs.subtracting(rhs)
    }
    
    @inlinable public static func &-=(lhs: inout Self, rhs: UInt) {
        lhs.subtractWrappingAround(rhs)
    }
    
    @inlinable public static func &-(lhs: Self, rhs: UInt) -> Self {
        lhs.subtractingWrappingAround(rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtract(_ amount: UInt, at index: Int = 0) {
        self.body.subtract(amount, at: index)
    }
    
    @inlinable public func subtracting(_ amount: UInt, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.subtracting(amount, at: index))
    }
    
    @inlinable public mutating func subtractWrappingAround(_ amount: UInt, at index: Int = 0) {
        self.body.subtractWrappingAround(amount, at: index)
    }
    
    @inlinable public func subtractingWrappingAround(_ amount: UInt, at index: Int = 0) -> Self {
        Self(bitPattern: self.body.subtractingWrappingAround(amount))
    }
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: UInt, at index: Int = 0) -> Bool {
        self.body.subtractReportingOverflow(amount, at: index)
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: UInt, at index: Int = 0) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, at: index); return (pv, o)
    }
}
