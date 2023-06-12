//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Full Width x Addition x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func addReportingOverflow(_ other: Digit) -> Bool {
        self.withUnsafeMutableWords { this in
            let minus: Bool = other.isLessThanZero
            var carry: Bool = this.first.addReportingOverflow(UInt(bitPattern: other))
            //=----------------------------------=
            if  carry == minus { return false }
            let extra =  UInt(bitPattern: minus ? -1 : 1)
            //=----------------------------------=
            for index in 1 ..< this.lastIndex {
                carry = this[index].addReportingOverflow(extra)
                if carry == minus { return false }
            }
            //=----------------------------------=
            return this.tail.addReportingOverflow(Digit(bitPattern: extra))
        }
    }
    
    @_disfavoredOverload @inlinable public func addingReportingOverflow(_ other: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(other)
        return PVO(partialValue, overflow)
    }
}
