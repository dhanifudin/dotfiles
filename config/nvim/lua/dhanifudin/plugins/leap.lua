local leap = require("leap")
leap.opts.case_sensitive = true
leap.leap({ target_windows = { vim.fn.win_getid() } })
leap.add_default_mappings()
