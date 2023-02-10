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
    
    /// Removes and returns a sign prefix, if it exists.
    ///
    /// ```
    /// var a = "+?"[...]; a._removeSignPrefix() // a.removeFirst(); -> .plus
    /// var b = "-?"[...]; b._removeSignPrefix() // b.removeFirst(); -> .minus
    /// var c = "??"[...]; c._removeSignPrefix() // nil
    /// ```
    ///
    @inlinable public mutating func _removeSignPrefix() -> ANKSign? {
        switch true {
        case hasPrefix("+"): removeFirst(); return .plus
        case hasPrefix("-"): removeFirst(); return .minus
        default: return nil }
    }
    
    /// Removes and returns a radix literal prefix, if it exists.
    ///
    /// ```
    /// var a = "0x?"[...]; a._removeSignPrefix() // a.removeFirst(2); -> 0x10
    /// var b = "0o?"[...]; b._removeSignPrefix() // b.removeFirst(2); -> 0o10
    /// var c = "0b?"[...]; c._removeSignPrefix() // c.removeFirst(2); -> 0b10
    /// var d = "???"[...]; d._removeSignPrefix() // nil
    /// ```
    ///
    @inlinable public mutating func _removeRadixLiteralPrefix() -> Int? {
        switch true {
        case hasPrefix("0x"): removeFirst(2); return 0x10
        case hasPrefix("0o"): removeFirst(2); return 0o10
        case hasPrefix("0b"): removeFirst(2); return 0b10
        default: return nil }
    }
}
