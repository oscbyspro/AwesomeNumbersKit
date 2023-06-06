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
// MARK: * ANK x Full Width x Addition
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ other: Self) -> Bool {
        var overflow = self.low.addReportingOverflow(other.low) as Bool
        overflow = overflow && self.high.addReportingOverflow(1 as Digit)
        return overflow != self.high.addReportingOverflow(other.high)
    }
    
    @inlinable public func addingReportingOverflow(_ other: Self) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(other)
        return PVO(partialValue, overflow)
    }
}
