#Include <UIAutomation>
#Include <BSTR>
#Include <ComVar>
#Include <Acc>

GetCaret(&X?, &Y?, &W?, &H?) {
    ; UIA caret
    static UIATextPattern2 := 10024
    focusedEl := UIA.GetFocusedElement()
    ; GetTextPattern2
    ComCall(16, focusedEl, "int", UIATextPattern2, "ptr*", &IUIATextPattern2:=0)
    if IUIATextPattern2 {
        ; GetCaretRange
        ComCall(10, IUIATextPattern2, "int*", 0, "ptr*", &CaretRange:=0)
        ObjRelease(IUIATextPattern2)
        try
            CaretRange := IUIAutomationTextRange(CaretRange)
        catch
            GoTo Acc
        CaretRect := CaretRange.GetBoundingRectangles()
        if CaretRect.MaxIndex() = 3 {
            X := CaretRect[0], Y := CaretRect[1], W := CaretRect[2], H := CaretRect[3]
            return 1
        }
    }

    ; ACC caret
    Acc:
    oAcc := Acc.ObjectFromWindow(WinExist("A"), Acc.OBJID.CARET)
    oAccCaret := oAcc.Location
    if (oAccCaret.X | oAccCaret.Y != 0) {
        X := oAccCaret.X, Y := oAccCaret.Y, W := oAccCaret.W, H := oAccCaret.H
        return 1
    }

    ; default caret
    ocm := CoordMode("Caret", "Screen")
    CaretGetPos &X, &Y
    CoordMode "Caret", ocm
    hwnd := ControlGetFocus("A")
    dc := DllCall("GetDC", "Ptr", hwnd)
    rect := Buffer(16, 0)
    ; 0x440 = DT_CALCRECT | DT_EXPANDTABS
    H := DllCall("DrawText", "Ptr", dc, "Ptr", StrPtr("I"), "Int", -1, "Ptr", rect, "UInt", 0x440)
    ; width = rect.right - rect.left
    W := NumGet(rect, 8, "Int") - NumGet(rect, 0, "Int")
    DllCall("ReleaseDC", "Ptr", hwnd, "Ptr", dc)
    return !(x = "" && y = "")
}