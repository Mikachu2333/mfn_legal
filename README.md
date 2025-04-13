# mfn_legal
make filename acceptable for windows

## Core Code
```rust
let result = text
  .replace('<', "＜")
  .replace('>', "＞")
  .replace(':', "：")
  .replace('"', "'")
  .replace('/', "／")
  .replace('\\', "＼")
  .replace('|', "｜")
  .replace('?', "？")
  .replace('*', "＊");
```
