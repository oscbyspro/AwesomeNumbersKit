//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Full Width x Division
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func /=(lhs: inout Self, rhs: Self) {
        let o = lhs.divideReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable public static func /(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.dividedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    @inlinable public static func %=(lhs: inout Self, rhs: Self) {
        let o = lhs.formRemainderReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable public static func %(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.remainderReportingOverflow(dividingBy: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.dividedReportingOverflow(by: divisor); return o
    }
    
    @inlinable func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(self, true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.remainderReportingOverflow(dividingBy: divisor); return o
    }
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(Self(), true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).remainder, false)
    }
    
    @inlinable func quotientAndRemainder(dividingBy rhs: Self) -> QR<Self, Self> {
        fatalError("TODO")
    }
    
    @inlinable func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        fatalError("TODO")
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Unsigned x Division
//*============================================================================*

extension OBEFullWidth where High: UnsignedInteger {
    
    #warning("TODO: reinterpret flexible-width implementation")
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
//    /// - https://github.com/hcs0/Hackers-Delight/blob/master/divmnu.c.txt
//    @inlinable @inline(never) static func formQuotientAndRemainderAsKnuth(dividing lhs: inout Self, by rhs: inout Self) {
//        precondition(!rhs.isZero)
//        //=--------------------------------------=
//        // Fast
//        //=--------------------------------------=
//        switch compare(lhs, to: rhs) {
//        case .less: (lhs, rhs) = (0, lhs); return
//        case .same: (lhs, rhs) = (1,   0); return
//        case .more: break }
//        //=--------------------------------------=
//        // Fast x UInt
//        //=--------------------------------------=
//        if  rhs._storage.count == 1 {
//            rhs = Self(lhs.formQuotientReportingRemainder(dividingBy: rhs._storage.first!))
//            return
//        }
//        //=--------------------------------------=
//        //
//        //=--------------------------------------=
//        let normalization = rhs._storage.last!.leadingZeroBitCount
//        lhs._bitshiftLeft(bits: normalization)
//        rhs._bitshiftLeft(bits: normalization)
//        //=--------------------------------------=
//        //
//        //=--------------------------------------=
//        let lhsCount = lhs._storage.count
//        let rhsCount = rhs._storage.count
//
//        let rhs0 = rhs._storage[rhsCount - 1]
//        let rhs1 = rhs._storage[rhsCount - 2]
//        let rhsX = (rhs0, rhs1)
//
//        let quotient = fromUnsafeUninitializedTwosComplementWords(count: 1 + lhsCount - rhsCount) { QUOTIENT in
//            for index in (rhsCount ..< lhsCount + 1).reversed() {
//                let lhsIndex = index - rhsCount
//                //=------------------------------=
//                // LHS Mutates In Each Loop
//                //=------------------------------=
//                let lhs0 = index     < lhs._storage.endIndex ? lhs._storage[index    ] : 0
//                let lhs1 = index - 1 < lhs._storage.endIndex ? lhs._storage[index - 1] : 0
//                let lhs2 = index - 2 < lhs._storage.endIndex ? lhs._storage[index - 2] : 0
//                let lhsX = (lhs0, lhs1, lhs2)
//                //=------------------------------=
//                // Approximation - Quotient <= 1
//                //=------------------------------=
//                var approximateQuotientWord = UInt.approximateQuotientAsKnuth(dividing: lhsX, by: rhsX)
//                var product = rhs.multiplied(by:   approximateQuotientWord)
//                //=------------------------------=
//                // Overestimation By One Is Rare
//                //=------------------------------=
//                overestimated: if _compareTwosComplementAsUnsigned(product._storage,
//                lhs._storage.suffix(from: Swift.min(lhs._storage.endIndex, lhsIndex))) == .more {
//                    product.subtract(rhs)
//                    approximateQuotientWord -= 1
//                }
//                //=------------------------------=
//                //
//                //=------------------------------=
//                lhs.subtract(product, at: lhsIndex)
//                QUOTIENT[lhsIndex] = approximateQuotientWord
//            }
//        }
//        //=--------------------------------------=
//        //
//        //=--------------------------------------=
//        rhs = lhs
//        rhs >>= normalization
//        lhs = quotient
//    }
}
