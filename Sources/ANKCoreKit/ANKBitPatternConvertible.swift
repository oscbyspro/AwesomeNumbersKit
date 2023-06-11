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
    /// Types with compatible bit patterns should have the same bit pattern type.
    ///
    associatedtype BitPattern: ANKBitPatternConvertible<BitPattern> & Sendable
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit pattern.
    ///
    /// ```
    /// ┌─────────── ⇄ ─────────── ⇄ ────────────┐
    /// │ Int256     │             │ UInt256     │
    /// ├─────────── ⇄ ─────────── ⇄ ────────────┤
    /// │ Int256( 1) │ 0.........1 │ UInt256( 1) │
    /// │ Int256( 0) │ 0.......... │ UInt256( 0) │
    /// │ Int256(-1) │ 1.......... │ UInt256.max │
    /// │ Int256(-2) │ 1.........0 │ UInt256(~1) │
    /// └─────────── ⇄ ─────────── ⇄ ────────────┘
    /// ```
    ///
    @inlinable init(bitPattern: BitPattern)
    
    /// The bit pattern of this value.
    ///
    /// ```
    /// ┌─────────── ⇄ ─────────── ⇄ ────────────┐
    /// │ Int256     │             │ UInt256     │
    /// ├─────────── ⇄ ─────────── ⇄ ────────────┤
    /// │ Int256( 1) │ 0.........1 │ UInt256( 1) │
    /// │ Int256( 0) │ 0.......... │ UInt256( 0) │
    /// │ Int256(-1) │ 1.......... │ UInt256.max │
    /// │ Int256(-2) │ 1.........0 │ UInt256(~1) │
    /// └─────────── ⇄ ─────────── ⇄ ────────────┘
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
    /// ┌─────────── ⇄ ─────────── ⇄ ────────────┐
    /// │ Int256     │             │ UInt256     │
    /// ├─────────── ⇄ ─────────── ⇄ ────────────┤
    /// │ Int256( 1) │ 0.........1 │ UInt256( 1) │
    /// │ Int256( 0) │ 0.......... │ UInt256( 0) │
    /// │ Int256(-1) │ 1.......... │ UInt256.max │
    /// │ Int256(-2) │ 1.........0 │ UInt256(~1) │
    /// └─────────── ⇄ ─────────── ⇄ ────────────┘
    /// ```
    ///
    @inlinable public init(bitPattern source: some ANKBitPatternConvertible<BitPattern>) {
        self.init(bitPattern: source.bitPattern)
    }
}
