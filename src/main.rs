#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]
use arboard::Clipboard;
use single_instance::SingleInstance;

const GUID: &str = "59F0144294F774C4FE54DE79EAA84E55";

fn main() {
    // Use CreateMuteA to avoid multi-process
    let instance = Box::new(SingleInstance::new(GUID).unwrap());
    if !instance.is_single() {
        panic!("Multiple")
    };

    let mut last_text = String::new(); // 存储上一次的剪贴板内容

    loop {
        std::thread::sleep(std::time::Duration::from_secs(1));

        let mut clipboard = match Clipboard::new() {
            Ok(c) => c,
            Err(_) => {
                eprintln!("Failed to initialize clipboard.");
                continue; // 跳过本次循环
            }
        };

        let text = match clipboard.get_text() {
            Ok(t) => t,
            Err(_) => {
                eprintln!("Failed to read clipboard text.");
                continue; // 跳过本次循环
            }
        };

        if text == last_text {
            // 剪贴板内容未变化，跳过处理
            continue;
        }

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

        match clipboard.set_text(&result) {
            Ok(_) => {
                println!("Clipboard content updated successfully.");
                last_text = result; // 更新上一次的内容
            }
            Err(_) => {
                eprintln!("Failed to set clipboard text.");
                continue;
            }
        }
    }
}
