-- 入口：加载核心模块（顺序：选项/键位 -> lazy 管理器 -> 自动命令）
require("core.options")
require("core.keymaps")
require("core.lazy") -- 会在这里加载所有插件
require("core.autocmds")
