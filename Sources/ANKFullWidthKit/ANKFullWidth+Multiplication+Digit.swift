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
        let overflow: Bool = lhs.multiplyReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    @inlinable public static func *(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by amount: Digit) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero as Bool
        let product = self.multipliedFullWidth(by: amount) as HL<Digit, Magnitude>
        let overflow: Bool = isLessThanOrEqualToZero ? product.high < (-1 as Digit) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        let hl: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: hl.low); return hl.high
    }
    
    @inlinable public func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        //=--------------------------------------=
        if  amount.isZero {
            return HL(Digit(), Magnitude())
        }
        //=--------------------------------------=
        let lhsIsLessThanZero: Bool =   self.isLessThanZero
        let rhsIsLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        var high = UInt()
        let low: Magnitude = self.withUnsafeWordsPointer { LHS in
        Magnitude.fromUnsafeMutableWordsAllocation { LOW in
            //=----------------------------------=
            var rhsSignCarry = rhsIsLessThanZero
            let rhsWord = UInt(bitPattern: amount)
            //=----------------------------------=
            for index in LHS.indices {
                let lhsWord = LHS[index]
                (high, LOW[index]) = high.addingFullWidth(multiplicands:(lhsWord, rhsWord))
                if rhsIsLessThanZero { rhsSignCarry = high.addReportingOverflow(~lhsWord, rhsSignCarry) }
            }
            //=----------------------------------=
            high = lhsIsLessThanZero ? high &+ rhsWord.twosComplement() : high
        }}
        //=--------------------------------------=
        return HL(Digit(bitPattern: high), low)
    }
}
