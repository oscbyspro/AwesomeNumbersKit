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
// MARK: * OBE x Fixed Width Integer
//*============================================================================*

@usableFromInline protocol OBEFixedWidthInteger: AwesomeFixedWidthInteger where
Magnitude: OBEFixedWidthInteger, Magnitude.High == High.Magnitude, Magnitude.Low == Low {
    
    associatedtype High: AwesomeFixedWidthInteger
    
    associatedtype Low:  AwesomeFixedWidthInteger where Low == High.Magnitude
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @_hasStorage var _storage: DoubleWidth<High>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(ascending:(low: Low, high: High))
    
    @inlinable init(descending:(high: High, low: Low))
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: Magnitude) {
        self = unsafeBitCast(bitPattern, to: Self.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var high: High {
        _read   { yield  self._storage.high }
        _modify { yield &self._storage.high }
    }
    
    @inlinable var low:  Low  {
        _read   { yield  self._storage.low  }
        _modify { yield &self._storage.low  }
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Addition
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    // TODO: as Small or Pointer
    @inlinable public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let overflows: (Bool, Bool, Bool)
        overflows.0 = self.low .addReportingOverflow(amount.low )
        overflows.1 = self.high.addReportingOverflow(amount.high)
        overflows.2 = self.high.addReportingOverflow(overflows.0 ? 1 : 0 as High)
        return overflows.1 || overflows.2
    }
    
    @inlinable public mutating func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Subtraction
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    // TODO: as Small or Pointer
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let overflows: (Bool, Bool, Bool)
        overflows.0 = self.low .subtractReportingOverflow(amount.low )
        overflows.1 = self.high.subtractReportingOverflow(amount.high)
        overflows.2 = self.high.subtractReportingOverflow(overflows.0 ? 1 : 0 as High)
        return overflows.1 || overflows.2
    }
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Multiplication
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func multipliedFullWidth(by other: Self) -> HL<Self, Magnitude> {
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
        let resultIsLessThanZero = self.isLessThanZero != other.isLessThanZero
        
        let lhs =  self.magnitude
        let rhs = other.magnitude
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
