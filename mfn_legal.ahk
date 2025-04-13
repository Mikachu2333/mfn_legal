#Requires AutoHotkey v2.0
#SingleInstance Force

; 存储上一次的剪贴板内容
LastClipboard := ""

; 添加启动提示
MsgBox("脚本已启动，正在监听剪贴板...")

; 确保事件监听器正确绑定
OnClipboardChange(ClipChanged)

ClipChanged(DataType) {
    if (DataType == "Text") {
        ; 获取当前剪贴板内容
        CurrentClip := A_Clipboard

        ; 添加调试信息
        ToolTip("检测到剪贴板变化: " CurrentClip)
        SetTimer () => ToolTip(), -1000  ; 1秒后自动消失

        ; 检查内容是否与上次不同
        if (CurrentClip != LastClipboard) {
            ; 添加处理提示
            ToolTip("正在处理文本...")

            NewText := StrReplace(CurrentClip, "<", "＜")
            NewText := StrReplace(NewText, ">", "＞")
            NewText := StrReplace(NewText, ":", "：")
            NewText := StrReplace(NewText, '"', "'")
            NewText := StrReplace(NewText, "/", "／")
            NewText := StrReplace(NewText, "\", "＼")
            NewText := StrReplace(NewText, "|", "｜")
            NewText := StrReplace(NewText, "?", "？")
            NewText := StrReplace(NewText, "*", "＊")

            ; 暂时关闭剪贴板监听
            OnClipboardChange(ClipChanged, 0)

            ; 更新剪贴板内容
            A_Clipboard := NewText

            ; 更新LastClipboard为处理后的内容
            LastClipboard := NewText

            ; 重新启用剪贴板监听
            OnClipboardChange(ClipChanged, 1)

            ; 显示处理完成提示
            ToolTip("文本处理完成！")
            SetTimer () => ToolTip(), -1000
        }
    }
}
