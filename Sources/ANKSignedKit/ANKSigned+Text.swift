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
    
    @_transparent public var description: String {
        String(encoding: self)
    }
    
    @inlinable public var debugDescription: String {
        "\(Self.self)(sign: \(sign), magnitude: \(magnitude))"
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Text x Big Endian Text Codable
//*============================================================================*

extension ANKSigned where Magnitude: ANKBigEndianTextCodable {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        let components = source._bigEndianTextComponents(radix: radix)
        guard let magnitude = Magnitude.decodeBigEndianText(components.body, radix: components.radix) else { return nil }
        return Self(magnitude, as: components.sign)
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        let magnitudeBigEndianText = Magnitude.encodeBigEndianText(source.magnitude, radix: radix, uppercase: uppercase)
        return source.isLessThanZero ? "-" + magnitudeBigEndianText : magnitudeBigEndianText
    }
}
