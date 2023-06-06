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
// MARK: * ANK x Full Width x Subtraction x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func subtractReportingOverflow(_ other: Digit) -> Bool {
        self.withUnsafeMutableWords { SELF in
            let minus: Bool = other.isLessThanZero
            var carry: Bool = SELF.first.subtractReportingOverflow(UInt(bitPattern: other))
            //=----------------------------------=
            if  carry == minus { return false }
            let extra =  UInt(bitPattern: minus ? -1 : 1)
            //=----------------------------------=
            for index in 1 ..< SELF.lastIndex {
                carry =  SELF[index].subtractReportingOverflow(extra)
                if carry == minus { return false }
            }
            //=----------------------------------=
            let pvo: PVO<Digit> = Digit(bitPattern: SELF.last).subtractingReportingOverflow(Digit(bitPattern: extra))
            SELF.last = UInt(bitPattern: pvo.partialValue)
            return pvo.overflow as Bool
        }
    }
    
    @_disfavoredOverload @inlinable public func subtractingReportingOverflow(_ other: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(other)
        return PVO(partialValue, overflow)
    }
}
