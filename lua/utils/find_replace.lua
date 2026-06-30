local M = {}

local state = {
  win = nil,
  hl  = {},
}

local function close()
  for _, id in ipairs(state.hl) do
    pcall(vim.fn.matchdelete, id)
  end
  state.hl = {}
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
end

local function highlight_in_range(start_line, end_line, pattern)
  for _, id in ipairs(state.hl) do
    pcall(vim.fn.matchdelete, id)
  end
  state.hl = {}

  local cur = vim.api.nvim_get_current_win()
  local id = vim.fn.matchadd("Search", "\\V" .. pattern, 100, -1, {
    window = cur,
  })
  table.insert(state.hl, id)
end

local function do_replace(start_line, end_line, search, repl)
  local esc = search:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local count = 0
  for i, line in ipairs(lines) do
    local new_line, n = (line:gsub(esc, function() count = count + 1; return repl end))
    lines[i] = new_line
  end
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
  return count
end

local function open_float()
  local lines = {
    "",
    "",
    " [Enter] Reemplazar  |  [Esc] Cancelar",
  }
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "filetype", "find_replace")

  local width = vim.o.columns
  local col = math.floor((vim.o.columns - 40) / 2)
  state.win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = 5,
    col = col,
    width = 40,
    height = #lines,
    border = "rounded",
    title = " Buscar y Reemplazar ",
    title_pos = "center",
    style = "minimal",
  })
  vim.wo[state.win].wrap = false
  vim.wo[state.win].relativenumber = false
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "SnacksPickerBorder" })
end

function M.visual_find_replace()
  local mode = vim.fn.mode()
  if not (mode:match("^V") or mode:match("^v")) then
    return
  end

  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)

  vim.schedule(function()
    local s = vim.fn.line("v")
    local e = vim.fn.line(".")
    if s > e then s, e = e, s end

    local sel = table.concat(
      vim.api.nvim_buf_get_lines(0, s - 1, e, false),
      "\n"
    )

    open_float()

    vim.ui.input({ prompt = "Buscar: ", default = sel }, function(input)
      if not input or input == "" then
        close()
        vim.notify("Búsqueda cancelada", vim.log.levels.INFO)
        return
      end

      highlight_in_range(s, e, input)

      vim.ui.input({ prompt = "Reemplazar con: ", default = "" }, function(repl)
        if repl == nil then
          close()
          vim.notify("Reemplazo cancelado", vim.log.levels.INFO)
          return
        end

        local count = do_replace(s, e, input, repl)
        close()
        vim.notify(
          string.format("Reemplazadas %d ocurrencia(s) entre líneas %d-%d", count, s, e),
          vim.log.levels.INFO
        )
      end)
    end)
  end)
end

return M
