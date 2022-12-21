//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Multiplication
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func *=(lhs: inout Self, rhs: Self) {
        lhs.body.multiplyAsKaratsuba(by: rhs.body)
    }
    
    @_transparent public static func *(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body.multipliedAsKaratsuba(by: rhs.body))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        self.body.multiplyReportingOverflowAsKaratsuba(by: amount.body)
    }
    
    @_transparent public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        Self.pvo(body.multipliedReportingOverflowAsKaratsuba(by: amount.body))
    }
    
    @_transparent public mutating func multiplyFullWidth(by amount: Self) -> Self {
        Self.h(l: &self, body.multipliedFullWidthAsKaratsuba(by: amount.body))
    }
    
    @_transparent public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        Self.hl(body.multipliedFullWidthAsKaratsuba(by: amount.body))
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned x Multiplication
//*============================================================================*

extension ANKUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    //=------------------------------------------------------------------------=
    // the compiler should optimize the general case but I am not sure it does
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func multiplyFullWidth(by amount: Self) -> Self {
        Self.h(l: &self, body.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.body))
    }
    
    @_transparent public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        Self.hl(body.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.body))
    }
}
