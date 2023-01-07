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
// MARK: * ANK x Text
//*============================================================================*

extension StringProtocol where Self == SubSequence {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func removeSignPrefix() -> Bool? {
        switch true {
        case hasPrefix("+"): removeFirst(); return false
        case hasPrefix("-"): removeFirst(); return  true
        default: return nil }
    }
    
    @inlinable mutating func removeRadixLiteralPrefix() -> Int? {
        switch true {
        case hasPrefix("0x"): removeFirst(2); return 16
        case hasPrefix("0o"): removeFirst(2); return 08
        case hasPrefix("0b"): removeFirst(2); return 02
        default: return nil }
    }
}
