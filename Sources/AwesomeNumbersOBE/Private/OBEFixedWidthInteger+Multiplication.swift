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
        fatalError("TODO")
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        fatalError("TODO")
    }
    
    // FIXME: @_transparent to erase protocol because @_specialize(where:) does not work
    @_transparent public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        //=--------------------------------------=
        //
        //=--------------------------------------=
        func sum(_ x0: Low, _ x1: Low, _ x2: Low) -> (high: Low, low: Low) {
            let (x3, o3) = x0.addingReportingOverflow(x1)
            let (x4, o4) = x3.addingReportingOverflow(x2)
            let (x5) = o3 && o4 ? 2 : o3 || o4 ? 1 : 0 as Low // TODO: as UInt
            return (x4, x5)
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let resultIsLessThanZero = self.isLessThanZero != amount.isLessThanZero
        
        let lhs =   self.magnitude
        let rhs = amount.magnitude
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let mul0 = rhs.low .multipliedFullWidth(by: lhs.low )
        let mul1 = rhs.low .multipliedFullWidth(by: lhs.high)
        let mul2 = rhs.high.multipliedFullWidth(by: lhs.low )
        let mul3 = rhs.high.multipliedFullWidth(by: lhs.high)
        
        let sum0 = sum(mul0.high, mul1.low,  mul2.low)
        let sum1 = sum(mul1.high, mul2.high, mul3.low)
        
        // TODO: sum.high is <= 2 and can be UInt
        var low  = Magnitude(descending:(sum0.low,              mul0.low            ))
        var high = Magnitude(descending:(mul3.high + sum1.high, sum0.high + sum1.low))
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  resultIsLessThanZero {
            var carry: Bool // TODO: formTwosComplement()
            (low,  carry) = (~low ).addingReportingOverflow(1 as Magnitude)
            (high, carry) = (~high).addingReportingOverflow(carry ? 1 : 0 as Magnitude)
        }
        
        return HL(Self(bitPattern: high), low)
    }
}
