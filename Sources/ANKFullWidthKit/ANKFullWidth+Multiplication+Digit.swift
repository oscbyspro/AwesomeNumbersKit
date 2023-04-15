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
    
    @_disfavoredOverload @inlinable public static func *=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.multiplyReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    @_disfavoredOverload @inlinable public static func *(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func multiplyReportingOverflow(by  amount: Digit) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_disfavoredOverload @inlinable public func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let product = Plus1(descending: self.multipliedFullWidth(by: amount))
        //=--------------------------------------=
        let overflow: Bool
        if !Self.isSigned {
            overflow = !product.high.isZero
        } else if self.isLessThanZero != amount.isLessThanZero {
            overflow = product < Plus1(descending: HL(~Digit(), Magnitude(bitPattern: Self.min)))
        } else {
            overflow = product > Plus1(descending: HL( Digit(), Magnitude(bitPattern: Self.max)))
        }
        //=--------------------------------------=
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        let hl: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: hl.low); return hl.high
    }
    
    @_disfavoredOverload @inlinable public func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        //=--------------------------------------=
        if  amount.isZero {
            return HL(Digit(), Magnitude())
        }
        //=--------------------------------------=
        let lhsIsLessThanZero: Bool =   self.isLessThanZero
        let rhsIsLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        var high = UInt()
        let low: Magnitude = self.withUnsafeWords { LHS in
        Magnitude.fromUnsafeMutableWords { LOW in
            //=----------------------------------=
            let rhsWord = UInt(bitPattern: amount)
            var rhsIsLessThanZeroCarry = rhsIsLessThanZero
            //=----------------------------------=
            for index: Int in LHS.indices {
                let lhsWord: UInt  = LHS[index]
                (high, LOW[index]) = high.addingFullWidth(multiplicands:(lhsWord, rhsWord))
                if  rhsIsLessThanZero {
                    rhsIsLessThanZeroCarry = high.addReportingOverflow(~lhsWord, rhsIsLessThanZeroCarry)
                }
            }
            //=----------------------------------=
            high = lhsIsLessThanZero ? high &+ rhsWord.twosComplement() : high
        }}
        //=--------------------------------------=
        return HL(Digit(bitPattern: high), low)
    }
}
