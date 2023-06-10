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
// MARK: * ANK x Full Width x Arithmetic
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// The absolute value of the remainder of dividing this value by its bit width.
    @inlinable var _moduloBitWidth: Int {
        //=--------------------------------------=
        if  Self.bitWidth.isPowerOf2 {
            return  Int(bitPattern: self.first) & (Self.bitWidth &- 1)
        }
        //=--------------------------------------=
        let value = Int(bitPattern: self % Digit(bitPattern: Self.bitWidth))
        return self.isLessThanZero ? -value : value
    }
}
