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
// MARK: * ANK x Signed x Text
//*============================================================================*

extension ANKSigned where Magnitude: ANKBigEndianTextCodable {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        var bigEndianText = source[...]
        let sign  = bigEndianText._removeSignPrefix() ?? ANKSign.plus
        let radix = radix ?? bigEndianText._removeRadixLiteralPrefix() ?? 10
        let magnitude = Magnitude.decodeBigEndianText(bigEndianText, radix: radix)
        guard  let  magnitude else { return nil }
        return Self(magnitude, as: sign)
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        let magnitudeBigEndianText = Magnitude.encodeBigEndianText(source.magnitude, radix: radix, uppercase: uppercase)
        return source.isLessThanZero ? "-" + magnitudeBigEndianText : magnitudeBigEndianText
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Text x Literal
//*============================================================================*

extension ANKSigned where Magnitude: ANKBigEndianTextCodable {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(stringLiteral source: String) {
        self.init(decoding: source, radix: nil)!
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Text x Description
//*============================================================================*

extension ANKSigned where Magnitude: ANKBigEndianTextCodable {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var description: String {
        String(encoding: self)
    }
    
    @inlinable public var debugDescription: String {
        "\(Self.self)(sign: \(sign), magnitude: \(magnitude))"
    }
}
