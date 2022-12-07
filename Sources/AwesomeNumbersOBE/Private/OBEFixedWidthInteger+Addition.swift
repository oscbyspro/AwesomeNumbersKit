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
