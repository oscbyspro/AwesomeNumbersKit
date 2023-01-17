//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Text
//*============================================================================*

extension StringProtocol where Self == SubSequence {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func _removeSignPrefix() -> ANKSign? {
        switch true {
        case hasPrefix("+"): removeFirst(); return .plus
        case hasPrefix("-"): removeFirst(); return .minus
        default: return nil }
    }
    
    @inlinable public mutating func _removeRadixLiteralPrefix() -> Int? {
        switch true {
        case hasPrefix("0x"): removeFirst(2); return 0x10
        case hasPrefix("0o"): removeFirst(2); return 0o10
        case hasPrefix("0b"): removeFirst(2); return 0b10
        default: return nil }
    }
}
