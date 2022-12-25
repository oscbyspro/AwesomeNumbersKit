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
        precondition(!lhs.multiplyReportingOverflow(by: rhs))
    }
    
    @inlinable public static func *(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyReportingOverflow(by amount: Digit) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let isLessThanOrEqualToZero: Bool = self.isLessThanZero != amount.isLessThanZero
        let product: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < (-1 as Digit)) : !product.high.isZero
        return PVO(Self(bitPatternAsMagnitude: product.low), overflow)
    }
    
    @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        let hl: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPatternAsMagnitude: hl.low); return hl.high
    }
    
    @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        self.withUnsafeWords { LHS in
            if amount.isZero { return HL(Digit(), Magnitude()) }
            //=----------------------------------=
            let product = ExtraDigitWidth.fromUnsafeTemporaryWords { PRODUCT in
                var a = UInt()
                var b = amount.isLessThanZero as Bool
                let x = UInt(bitPattern: amount)
                //=------------------------------=
                for i in LHS.indices {
                    let y: UInt = LHS[unchecked: i]
                    let p: HL<UInt, UInt> = a.addingFullWidth(multiplicands:(y, x))
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
