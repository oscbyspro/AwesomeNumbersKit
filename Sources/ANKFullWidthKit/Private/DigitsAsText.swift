//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Digits To Text x Encode
//*============================================================================*

/// Encodes digits from `0` through `36` to ASCII.
///
/// ```swift
/// let alphabet =  DigitsToText(uppercase: true)
/// alphabet[00] // UInt8(ascii: "0")
/// alphabet[10] // UInt8(ascii: "A")
/// alphabet[20] // UInt8(ascii: "K")
/// alphabet[30] // UInt8(ascii: "U")
/// alphabet[40] // crash
/// ```
///
@frozen @usableFromInline struct DigitsToText {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let map00To10: UInt
    @usableFromInline let map10To37: UInt
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(uppercase: Bool) {
        self.map00To10 = 48
        self.map10To37 = uppercase ? 55 : 87
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable subscript(unchecked value: UInt) -> UInt8 {
        assert(value < 37)
        let offset = value < 10 ? map00To10 : map10To37
        return UInt8(_truncatingBits: value &+ offset)
    }
}
