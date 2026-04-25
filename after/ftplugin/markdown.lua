function _G.markdown_foldexpr()
  local lnum = vim.v.lnum
  local line = vim.fn.getline(lnum)
  local heading = line:match("^(#+)%s")
  if heading then
    local level = #heading
    if level == 1 then
      if lnum == 1 then
        return ">1"
      else
        local frontmatter_end = vim.b.frontmatter_end
        if frontmatter_end and (lnum == frontmatter_end + 1) then
          return ">1"
        end
      end
    elseif level >= 2 and level <= 6 then
      return ">" .. level
    end
  end
  return "="
end

local function set_markdown_folding()
  vim.opt_local.foldmethod = "expr"
  vim.opt_local.foldexpr = "v:lua.markdown_foldexpr()"
  vim.opt_local.foldlevel = 99

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_first = false
  local frontmatter_end = nil
  for i, line in ipairs(lines) do
    if line == "---" then
      if not found_first then
        found_first = true
      else
        frontmatter_end = i
        break
      end
    end
  end
  vim.b.frontmatter_end = frontmatter_end
end

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
  -- Move to the top of the file without adding to jumplist
  vim.cmd("keepjumps normal! gg")
  -- Get the total number of lines
  local total_lines = vim.fn.line("$")
  for line = 1, total_lines do
    -- Get the content of the current line
    local line_content = vim.fn.getline(line)
    -- "^" -> Ensures the match is at the start of the line
    -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
    -- "%s" -> Matches any whitespace character after the "#" characters
    -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
    if line_content:match("^" .. string.rep("#", level) .. "%s") then
      -- Move the cursor to the current line without adding to jumplist
      vim.cmd(string.format("keepjumps call cursor(%d, 1)", line))
      -- Check if the current line has a fold level > 0
      local current_foldlevel = vim.fn.foldlevel(line)
      if current_foldlevel > 0 then
        -- Fold the heading if it matches the level
        if vim.fn.foldclosed(line) == -1 then
          vim.cmd("normal! za")
        end
        -- else
        --   vim.notify("No fold at line " .. line, vim.log.levels.WARN)
      end
    end
  end
end

local function fold_markdown_headings(levels)
  -- I save the view to know where to jump back after folding
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    fold_headings_of_level(level)
  end
  vim.cmd("nohlsearch")
  -- Restore the view to jump to where I was
  vim.fn.winrestview(saved_view)
end

--- Function that wraps main folding function to set up the environment for
--- folding
---@param levels table<number>
local function fold_prelude(levels)
  vim.cmd("silent update")
  vim.cmd("edit!")
  vim.cmd("normal! zR")
  fold_markdown_headings(levels)
  vim.cmd("normal! zz")
end

local function fold_h2() fold_prelude({ 6, 5, 4, 3, 2 }) end
local function fold_h3() fold_prelude({ 6, 5, 4, 3 }) end
local function fold_h4() fold_prelude({ 6, 5, 4 }) end
local function fold_h5() fold_prelude({ 6, 5 }) end

local loc = vim.opt_local

loc.expandtab = true
loc.shiftwidth = 2
loc.softtabstop = 2

loc.wrap = true
loc.linebreak = true
loc.textwidth = 80

set_markdown_folding()

vim.keymap.set("n", "zu", fold_h2, { desc = "Fold all headings level 2 or above" })
vim.keymap.set("n", "z;", fold_h3, { desc = "Fold all headings level 3 or above" })
vim.keymap.set("n", "zj", fold_h4, { desc = "Fold all headings level 4 or above" })
vim.keymap.set("n", "zk", fold_h5, { desc = "Fold all headings level 5 or above" })

vim.keymap.set("n", "zi", function()
  vim.cmd("silent update")
  vim.cmd("normal [[")
  vim.cmd("normal! za")
  vim.cmd("normal! zz")
end, { desc = "[P]Fold the heading cursor currently on" })
