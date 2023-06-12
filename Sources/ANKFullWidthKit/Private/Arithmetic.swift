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
// MARK: * ANK x Arithmetic x Modulo
//*============================================================================*

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns `self` modulo `self.bitWidth`.
    @inlinable func moduloBitWidth() -> Int where Self: ANKFixedWidthInteger, Self.Digit: ANKCoreInteger<UInt> {
        self.moduloBitWidth(of: Self.self)
    }
    
    /// Returns `self` modulo `other.bitWidth`.
    @inlinable func moduloBitWidth<T>(of other: T.Type) -> Int where T: ANKFixedWidthInteger, T.Digit: ANKCoreInteger<UInt> {
        //=--------------------------------------=
        if  T.bitWidth.isPowerOf2 {
            return Int(bitPattern: self._lowWord) & (T.bitWidth &- 1)
        //=--------------------------------------=
        }   else if T.bitWidth >= self.bitWidth {
            let minus: Bool = self < (0 as Self)
            let divisor   = T.Magnitude.Digit(bitPattern: T.bitWidth)
            let magnitude = T.Magnitude(truncatingIfNeeded: self.magnitude)
            let remainder = Int(bitPattern: magnitude % divisor)
            return Int(bitPattern: minus ? T.bitWidth - remainder : remainder)
        //=--------------------------------------=
        }   else {
            let minus: Bool = self < (0 as Self)
            let divisor   = Magnitude(truncatingIfNeeded: T.bitWidth)
            let magnitude = Magnitude(truncatingIfNeeded: self.magnitude)
            let remainder = Int(bitPattern: (magnitude % divisor)._lowWord)
            return Int(bitPattern: minus ? T.bitWidth - remainder : remainder)
        }
    }
}
