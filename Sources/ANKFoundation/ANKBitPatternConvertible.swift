//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Bit Pattern Convertible
//*============================================================================*

/// A type that can be converted to and from a bit pattern representation.
///
/// `init(bitPattern:)` is a type-safe alternative to `unsafeBitCast(_:to:)`.
/// 
public protocol ANKBitPatternConvertible<BitPattern> {
    
    /// The bit pattern of this type.
    ///
    /// Types with identical bit patterns should have the same bit pattern type.
    ///
    associatedtype BitPattern: ANKBitPatternConvertible<BitPattern>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit pattern.
    ///
    /// ```
    /// Int8(bitPattern: UInt8(255)) // Int8(-1)
    /// ```
    ///
    @inlinable init(bitPattern: BitPattern)
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns the bit pattern of this value.
    ///
    /// ```
    /// Int8(-1).bitPattern // UInt8(255)
    /// ```
    ///
    @inlinable var bitPattern: BitPattern { get }
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKBitPatternConvertible {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit pattern.
    ///
    /// ```
    /// Int8(bitPattern: UInt8(255)) // Int8(-1)
    /// ```
    ///
    @_transparent public init(bitPattern source: some ANKBitPatternConvertible<BitPattern>) {
        self.init(bitPattern: source.bitPattern)
    }
}

//*============================================================================*
// MARK: * ANK x Bit Pattern Convertible x Never
//*============================================================================*

extension Never: ANKBitPatternConvertible { }
extension ANKBitPatternConvertible<Never> {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var bitPattern: Never {
        fatalError()
    }
}
