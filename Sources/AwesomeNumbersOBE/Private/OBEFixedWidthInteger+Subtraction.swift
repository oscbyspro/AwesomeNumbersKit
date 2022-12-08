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
// MARK: * OBE x Fixed Width Integer x Subtraction
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let overflows: (Bool, Bool, Bool)
        overflows.0 = self.low .subtractReportingOverflow(amount.low )
        overflows.1 = self.high.subtractReportingOverflow(amount.high)
        overflows.2 = self.high.subtractReportingOverflow(overflows.0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return overflows.1 || overflows.2
    }
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}
