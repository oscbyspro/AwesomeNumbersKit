//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Integer x Text
//*============================================================================*

extension _ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        Body.decodeBigEndianText(source, radix: radix).map(Self.init(bitPattern:))
    }
    
    @_transparent public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool = false) -> String {
        Body.encodeBigEndianText(source.body, radix: radix, uppercase: uppercase)
    }
}

//*============================================================================*
// MARK: * ANK x Integer x Text x Descriptions
//*============================================================================*

extension _ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var debugDescription: String {
        "\(Self.self)(\(self.body.lazy.map(String.init).joined(separator: ", ")))"
    }
}
