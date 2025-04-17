# mfn_legal
make filename acceptable for windows

## 警告与说明 Warning&Information
1. 本程序对程序员不友好！！！    This Process is not friendly for programmer!
2. 关闭请直接通过任务管理器      Please Close this process via Taskmgr.
3. 程序有防多开机制              This Program is in singal instance mode.
4. 没写检测剪贴板变化，纯靠1s一次的循环    This process based on a loop pre second.

## Core Code
```rust
let result = text
  .replace('<', '＜')
  .replace('>', '＞')
  .replace(':', '：')
  .replace('"', ''')
  .replace('/', '／')
  .replace('\\', '＼')
  .replace('|', '｜')
  .replace('?', '？')
  .replace('*', '＊');
```
