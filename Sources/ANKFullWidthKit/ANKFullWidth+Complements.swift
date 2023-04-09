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
// MARK: * ANK x Full Width x Complements
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Bit Pattern
    //=------------------------------------------------------------------------=
    
    @_transparent public var bitPattern: BitPattern {
        unsafeBitCast(self, to: BitPattern.self)
    }
    
    @_transparent public init(bitPattern source: some ANKBitPatternConvertible<BitPattern>) {
        self = unsafeBitCast(source.bitPattern, to: Self.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Magnitude
    //=------------------------------------------------------------------------=
    
    @inlinable public var magnitude: Magnitude {
        Magnitude(bitPattern: self.isLessThanZero ? self.twosComplement() : self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Two's Complement
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func formTwosComplement() {
        self.withUnsafeMutableWords { SELF in
            var carry: Bool = true
            for index: Int in SELF.indices {
                (SELF[index], carry) = (~SELF[index]).addingReportingOverflow(UInt(bit: carry))
            }
        }
    }
    
    @_transparent public func twosComplement() -> Self {
        var next = self; next.formTwosComplement(); return next
    }
}
