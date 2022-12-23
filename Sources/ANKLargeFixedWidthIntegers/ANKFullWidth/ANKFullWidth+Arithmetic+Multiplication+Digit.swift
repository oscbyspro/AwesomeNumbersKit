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
    
    @inlinable public static func *=(lhs: inout Self, rhs: Digit) {
        let o = lhs.multiplyReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable public static func *(lhs: Self, rhs: Digit) -> Self {
        let (pv, o) = lhs.multipliedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyReportingOverflow(by amount: Digit) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflow(by: amount); return o
    }
    
    @inlinable func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        let product  = self.multipliedFullWidth(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        let (high, low) = self.multipliedFullWidth(by: amount); self = Self(bitPattern: low); return high
    }
    
    @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Self.Magnitude> {
        self.withUnsafeWords { LHS in
            if amount.isZero { return HL(Digit(), Magnitude()) }
            //=----------------------------------=
            let product = ExtraDigitWidth.fromUnsafeTemporaryWords { PRODUCT in
                var a = UInt()
                var b = amount.isLessThanZero as Bool
                let x = UInt(bitPattern: amount)
                //=------------------------------=
                for i in LHS.indices {
                    let y = LHS[unchecked: i]
                    let p = a.addingFullWidth(multiplicands:(y, x))
                    (a, PRODUCT[unchecked: i]) = p
                    if (amount.isLessThanZero) { b = a.addReportingOverflow(~y, b) }
                }
                //=------------------------------=
                PRODUCT[unchecked: PRODUCT.lastIndex] = self.isLessThanZero ? a &+ ~x &+ 1 : a
            }
            //=----------------------------------=
            return HL(product.high, product.low)
        }
    }
}
