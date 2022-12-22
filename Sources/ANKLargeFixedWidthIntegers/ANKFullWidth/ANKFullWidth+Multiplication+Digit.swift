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
// MARK: * ANK x Full Width x Multiplication x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func *=(lhs: inout Self, rhs: Self.Digit) {
        let o = lhs.multiplyReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self.Digit) -> Self {
        let (pv, o) = lhs.multipliedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyReportingOverflow(by amount: Self.Digit) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflow(by: amount); return o
    }
    
    @inlinable func multipliedReportingOverflow(by amount: Self.Digit) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        let product  = self.multipliedFullWidth(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    @inlinable mutating func multiplyFullWidth(by amount: Self.Digit) -> Self.Digit {
        let (high, low) = self.multipliedFullWidth(by: amount); self = Self(bitPattern: low); return high
    }
    
    @inlinable func multipliedFullWidth(by amount:  Digit) -> HL<Self.Digit, Self.Magnitude> {
        let lhsIsLessThanZero =   self.isLessThanZero
        let rhsIsLessThanZero = amount.isLessThanZero
        //=--------------------------------------=
        var product = ANKFullWidth<Self.Digit, Self.Magnitude>()
        //=--------------------------------------=
        self.withUnsafeWords { LHS in
        product.withUnsafeMutableWords { PRODUCT in
            let rhsWord = UInt(bitPattern: amount)
            //=----------------------------------=
            var carry =  UInt()
            for index in LHS.indices {
                let lhsWord = LHS[unchecked: index]
                (carry, PRODUCT[unchecked: index]) = carry.addingFullWidth(multiplicands:(lhsWord, rhsWord))
            }
            
            let lhsWord = UInt(repeating: lhsIsLessThanZero)
            PRODUCT[unchecked:  PRODUCT.lastIndex] = carry.addingFullWidth(multiplicands:(lhsWord, rhsWord)).low
            //=----------------------------------=
            if  lhsIsLessThanZero {
                _ = PRODUCT[unchecked: PRODUCT.lastIndex].addReportingOverflow(~rhsWord, true)
            }
            //=----------------------------------=
            if  rhsIsLessThanZero {
                var carry = true; for index in LHS.indices {
                    let lhsWord = ~LHS[unchecked: index]
                    carry = PRODUCT[unchecked: index &+ 1].addReportingOverflow(~lhsWord, carry)
                }
            }
        }}
        //=--------------------------------------=
        return HL(product.high, product.low)
    }
}
