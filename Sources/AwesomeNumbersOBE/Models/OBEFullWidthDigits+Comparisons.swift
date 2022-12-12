//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width Digits x Comparisons
//*============================================================================*

extension OBEFullWidthDigits {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var isZero: Bool {
        allSatisfy({ $0.isZero })
    }
    
    @inlinable public var isLessThanZero: Bool {
        Layout.isSigned ? self[littleEndianIndex(lastIndex)].mostSignificantBit : false
    }
}
