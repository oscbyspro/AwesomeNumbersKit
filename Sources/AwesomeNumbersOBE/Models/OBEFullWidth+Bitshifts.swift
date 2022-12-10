//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width x Bith
//*============================================================================*

extension OBEDoubleWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: Int) {
        if rhs.isLessThanZero { lhs >>=  Int() - rhs; return }
        if rhs >= Self.bitWidth { lhs = Self();       return }
        lhs &<<= rhs
    }
    
    @inlinable public static func <<(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    @inlinable public static func >>=(lhs: inout Self, rhs: Int) {
        if rhs.isLessThanZero { lhs <<= Int() - rhs; return }
        if rhs >= Self.bitWidth { lhs = Self(repeating: lhs.isLessThanZero); return }
        lhs &>>= rhs
    }
    
    @inlinable public static func >>(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Int) {
        let rhs = _maskedByOneLessThanBitWidth(rhs)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  rhs >= Low.bitWidth {
            lhs.low  = Low()
            lhs.high = High(truncatingIfNeeded: lhs.low &<< (rhs &- Low.bitWidth))
            return
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if rhs.isZero { return }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        lhs.high &<<= High(rhs)
        lhs.high   |= High(truncatingIfNeeded: lhs.low &>> (Low(Low.bitWidth &- rhs)))
        lhs.low  &<<= rhs
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Int) {
        let rhs = _maskedByOneLessThanBitWidth(rhs)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  rhs >= Low.bitWidth {
            lhs.low  = Low(truncatingIfNeeded: lhs.high &>> High(rhs &- Low.bitWidth))
            lhs.high = High(repeating: lhs.high.isLessThanZero)
            return
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if rhs.isZero { return }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        lhs.low  &>>= rhs
        lhs.low    |= Low(truncatingIfNeeded: lhs.high &<< High(Low.bitWidth &- rhs))
        lhs.high &>>= High(rhs)
    }
    
    @inlinable public static func &>>(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func _maskedByOneLessThanBitWidth(_ x: Int) -> Int {
        x & Int(Self.bitWidth &- 1) // Self.bitWidth == pow(2, x)
    }
}
