//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitwise
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func ~(x: Self) -> Self {
        Self(descending:(~x.high, ~x.low))
    }
    
    @inlinable public static func &=(lhs: inout Self, rhs: Self) {
        lhs.low  &= rhs.low
        lhs.high &= rhs.high
    }
    
    @inlinable public static func |=(lhs: inout Self, rhs: Self) {
        lhs.low  |= rhs.low
        lhs.high |= rhs.high
    }
    
    @inlinable public static func ^=(lhs: inout Self, rhs: Self) {
        lhs.low  ^= rhs.low
        lhs.high ^= rhs.high
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public var byteSwapped: Self {
        Self(descending:(Self.reinterpret(low.byteSwapped), Self.reinterpret(high.byteSwapped)))
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Two's Complement
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func formTwosComplement() {
        self.withUnsafeMutableTwosComplementWords { SELF in
            var carry =  true
            for index in Self.indices {
                (SELF[index], carry) = (~SELF[index]).addingReportingOverflow(UInt(carry))
            }
        }
    }
    
    @inlinable public func twosComplement() -> Self {
        var x = self; x.formTwosComplement(); return x
    }
}
