//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Binary Integer x Big Endian Text Codable
//*============================================================================*

/// An integer type than can be decoded from and encoded to big endian text.
///
/// - Decode big endian text with `Self(decoding:radix:)`.
/// - Encode big endian text with `String(encoding:radix:uppercase:)`.
///
/// - Note: The `BinaryInteger` protocol in the standard library does not provide
///   customization points for its binary integer coding methods. Converting to
///   and from big endian text happens to be particularly well suited for machine
///   word arithmetic, however, so these methods were added instead.
///
public protocol ANKBigEndianTextCodable {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func decodeBigEndianText(_ source: some StringProtocol,  radix: Int?) -> Self?
    
    @inlinable static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKBigEndianTextCodable {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given string and optional radix.
    ///
    /// When the radix is `nil`, the radix is either decoded from the string or,
    /// if it is cannot be decoded form the string, it is assigned the value 10.
    ///
    @_transparent public init?(decoding source: some StringProtocol, radix: Int? = nil) {
        guard let value = Self.decodeBigEndianText(source, radix: radix) else { return nil }; self = value
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Details x String
//=----------------------------------------------------------------------------=

extension String {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a string representing the given value, using the given format.
    @_transparent public init(encoding source: some ANKBigEndianTextCodable, radix: Int = 10, uppercase: Bool = false) {
        self = type(of: source).encodeBigEndianText(source, radix: radix, uppercase: uppercase)
    }
}
