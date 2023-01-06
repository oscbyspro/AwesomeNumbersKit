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
// MARK: * ANK x Signed x Subtraction
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Self) {
        //=--------------------------------------=
        if  lhs.sign != rhs.sign {
            lhs.magnitude += rhs.magnitude
        //=--------------------------------------=
        }   else if lhs.magnitude >= rhs.magnitude {
            lhs.magnitude -= rhs.magnitude
        //=--------------------------------------=
        }   else {
            lhs.sign  = rhs.sign.toggled()
            lhs.magnitude  = rhs.magnitude - lhs.magnitude
        }
    }
    
    @_transparent public static func -(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs -= rhs; return lhs
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Subtraction
//*============================================================================*

extension ANKSigned where Magnitude: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ rhs: Self) -> Bool {
        fatalError("TODO")
    }
    
    @inlinable public func subtractingReportingOverflow(_ rhs: Self) -> PVO<Self> {
        fatalError("TODO")
    }
}
