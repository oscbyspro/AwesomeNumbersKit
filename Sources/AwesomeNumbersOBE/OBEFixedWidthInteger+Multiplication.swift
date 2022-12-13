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
// MARK: * OBE x Fixed Width Integer x Multiplication
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.multipliedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflow(by: amount); return o
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        let product  = self.multipliedFullWidth(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let product = body.multipliedFullWidthAsKaratsuba(by: amount.body)
        self = Self(bitPattern: product.low )
        return Self(bitPattern: product.high)
    }
    
    @inlinable public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let product = body.multipliedFullWidthAsKaratsuba(by: amount.body)
        return HL(Self(bitPattern: product.high), Magnitude(bitPattern: product.low))
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Multiplication x Unsigned
//*============================================================================*

extension OBEUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    //=------------------------------------------------------------------------=
    // the compiler should optimize the general case but I am not sure it does
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let product = body.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.body)
        self = Self(bitPattern: product.low )
        return Self(bitPattern: product.high)
    }
    
    @inlinable public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let product = body.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.body)
        return HL(Self(bitPattern: product.high), Magnitude(bitPattern: product.low))
    }
}
