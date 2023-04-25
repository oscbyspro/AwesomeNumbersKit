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
// MARK: * ANK x Signed
//*============================================================================*

extension ANKSigned: SignedNumeric {
    
    public typealias Digit = ANKSigned<Magnitude.Digit>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(bit: Bool) {
        let sign = ANKSign.plus
        let magnitude = Magnitude(bit: bit)
        self.init(magnitude, as: sign)
    }
    
    @inlinable public init(digit: Digit) {
        let sign = digit.sign
        let magnitude = Magnitude(digit: digit.magnitude)
        self.init(magnitude, as: sign)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Conditional Conformances
//*============================================================================*

extension ANKSigned: ANKBigEndianTextCodable      where Magnitude: ANKBigEndianTextCodable { }
extension ANKSigned: CustomStringConvertible      where Magnitude: ANKBigEndianTextCodable { }
extension ANKSigned: CustomDebugStringConvertible where Magnitude: ANKBigEndianTextCodable { }
