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
    
    public typealias IntegerLiteralType = Int
}

//*============================================================================*
// MARK: * ANK x Signed x Large
//*============================================================================*

extension ANKLargeSigned {
    
    public typealias Digit = ANKSigned<Magnitude.Digit>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(digit: Digit) {
        self.init(Magnitude(digit: digit.magnitude), as: digit.sign)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Conditional Conformances
//*============================================================================*

extension ANKSigned: CustomDebugStringConvertible where Magnitude: ANKBigEndianTextCodable { }
extension ANKSigned: CustomStringConvertible where Magnitude: ANKBigEndianTextCodable { }
extension ANKSigned: ExpressibleByUnicodeScalarLiteral where Magnitude: ANKBigEndianTextCodable { }
extension ANKSigned: ExpressibleByExtendedGraphemeClusterLiteral where Magnitude: ANKBigEndianTextCodable { }
extension ANKSigned: ExpressibleByStringLiteral where Magnitude: ANKBigEndianTextCodable { }
extension ANKSigned: ANKBigEndianTextCodable where Magnitude: ANKBigEndianTextCodable { }
