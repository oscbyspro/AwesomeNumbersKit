//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Aliases
//*============================================================================*

/// A high and a low value.
public typealias HL<H,L> = (high: H, low: L)

/// A low and a high value.
public typealias LH<L,H> = (low: L, high: H)

/// A partial value and a value indicating whether overflow occurred.
public typealias PVO<PV> = (partialValue: PV, overflow: Bool)

/// A quotient and a remainder, relating to division.
public typealias QR<Q,R> = (quotient: Q, remainder: R)

//*============================================================================*
// MARK: * Aliases x Models
//*============================================================================*

/// The sign of a numeric value.
public typealias Sign = ANKSign

/// A decorative, width agnostic, sign-and-magnitude, numeric integer.
public typealias Signed<T> = ANKSigned<T> where T: ANKUnsignedInteger, T == T.Magnitude
