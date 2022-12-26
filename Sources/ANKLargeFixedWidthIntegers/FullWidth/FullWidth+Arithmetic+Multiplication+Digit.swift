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
        let overflow: Bool = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        let hl: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: hl.low); return hl.high
    }
    
    @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        //=--------------------------------------=
        if amount.isZero { return HL(Digit(), Magnitude()) }
        //=--------------------------------------=
        var high = UInt()
        let low: Magnitude = self.withUnsafeWords { LHS in
        Magnitude.fromUnsafeTemporaryWords { LOW in
            var x = amount.isLessThanZero as Bool
            let rhsWord = UInt(bitPattern: amount)
            //=----------------------------------=
            for index in LHS.indices {
                let lhsWord = LHS[unchecked:  index]
                (high, LOW[unchecked: index]) = high.addingFullWidth(multiplicands:(lhsWord, rhsWord))
                if  amount.isLessThanZero { x = high.addReportingOverflow(~lhsWord, x) }
            }
            //=----------------------------------=
            high = self.isLessThanZero ? high &+ ~rhsWord &+ 1 : high
        }}
        //=--------------------------------------=
        return HL(Digit(bitPattern: high), low)
    }
}
