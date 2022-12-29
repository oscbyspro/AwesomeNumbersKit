//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Integer x Comparisons
//*============================================================================*

extension _ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var isZero: Bool {
        self.body.isZero
    }
    
    @_transparent public var isLessThanZero: Bool {
        self.body.isLessThanZero
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.body == rhs.body
    }
    
    @_transparent public static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.body <  rhs.body
    }
}
