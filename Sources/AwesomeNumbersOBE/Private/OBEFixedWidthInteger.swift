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

@usableFromInline protocol OBEFixedWidthInteger: AwesomeFixedWidthInteger {
    
    associatedtype High: AwesomeFixedWidthInteger
    
    associatedtype Low:  AwesomeFixedWidthInteger where Low == High.Magnitude
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @_hasStorage var _storage: DoubleWidth<High>
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
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
