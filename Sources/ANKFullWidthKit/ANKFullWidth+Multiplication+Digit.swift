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
    
    @_disfavoredOverload @inlinable public mutating func multiplyReportingOverflow(by  other: Digit) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_disfavoredOverload @inlinable public func multipliedReportingOverflow(by other: Digit) -> PVO<Self> {
        let product = Plus1(descending: self.multipliedFullWidth(by: other))
        //=--------------------------------------=
        let overflow: Bool
        if !Self.isSigned {
            overflow = !(product.high.isZero)
        }   else if self.isLessThanZero == other.isLessThanZero {
            // overflow = product > Self.max, but more efficient
            overflow = !(product.high.isZero && !product.low.mostSignificantBit)
        }   else {
            // overflow = product < Self.min, but more efficient
            overflow = !(product.high.isFull &&  product.low.mostSignificantBit) && product.high.mostSignificantBit
        }
        //=--------------------------------------=
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func multiplyFullWidth(by other: Digit) -> Digit {
        let product: HL<Digit, Magnitude> = self.multipliedFullWidth(by: other)
        self = Self(bitPattern: product.low)
        return product.high as  Digit
    }
    
    @_disfavoredOverload @inlinable public func multipliedFullWidth(by other: Digit) -> HL<Digit, Magnitude> {
        //=--------------------------------------=
        if  other.isZero {
            return HL(Digit(), Magnitude())
        }
        //=--------------------------------------=
        let lhsIsLessThanZero: Bool =  self.isLessThanZero
        let rhsIsLessThanZero: Bool = other.isLessThanZero
        //=--------------------------------------=
        var high = UInt()
        let low: Magnitude = self.withUnsafeWords { LHS in
            Magnitude.fromUnsafeMutableWords { LOW in
                //=------------------------------=
                let rhsWord = UInt(bitPattern: other)
                var rhsIsLessThanZeroCarry = rhsIsLessThanZero
                //=------------------------------=
                for index: Int in LHS.indices {
                    let lhsWord: UInt  = LHS[index]
                    (high, LOW[index]) = high.addingFullWidth(multiplicands:(lhsWord, rhsWord))
                    if  rhsIsLessThanZero {
                        rhsIsLessThanZeroCarry = high.addReportingOverflow(~lhsWord, rhsIsLessThanZeroCarry)
                    }
                }
                //=------------------------------=
                high = lhsIsLessThanZero ? high &+ rhsWord.twosComplement() : high
            }
        }
        //=--------------------------------------=
        return HL(Digit(bitPattern: high), low)
    }
}
