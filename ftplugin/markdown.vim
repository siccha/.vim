" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal textwidth=220
setlocal tabstop=2
setlocal shiftwidth=2
setlocal foldmethod=manual
setlocal nowrap

" https://github.com/kylechui/nvim-surround/discussions/53
lua <<EOF
require("nvim-surround").buffer_setup {
  surrounds = {
    ["l"] = {
      add = function()
        local clipboard = vim.fn.getreg("+"):gsub("^[%s\n]*(.-)[%s\n]*$", "%1")
        if clipboard:find("\n") then
          vim.notify("URL must not contain newline characters", vim.log.levels.WARN)
        else
          return {
            { "[" },
            { "](" .. clipboard .. ")" },
          }
        end
      end,
      find = "%b[]%b()",
      delete = "^(%[)().-(%]%b())()$",
      change = {
        target = "^()()%b[]%((.-)()%)$",
        replacement = function()
          local clipboard = vim.fn.getreg("+"):gsub("^[%s\n]*(.-)[%s\n]*$", "%1")
          if clipboard:find("\n") then
            vim.notify("URL must not contain newline characters", vim.log.levels.WARN)
          else
            return {
              { "" },
              { clipboard },
            }
          end
        end,
      },
    },
  },
}
EOF
