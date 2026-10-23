local M = {}

local function config_root()
  return os.getenv("CONFIG_ROOT") or vim.fn.stdpath("config")
end

--- Build lazy import specs for every .lua file under lua/<root/ recursively.
--- Files or folders starting with "_" are skipped
---@param root string e.g. "specs"
function M.import(root)
  local lua_dir = config_root() .. "/lua"
  local base = lua_dir .. "/" .. root:gsub("%.", "/")
  local files = vim.fn.globpath(base, "**/*.lua", false, true)
  table.sort(files)

  local specs = {}
  for _, file in ipairs(files) do
    local rel = file:sub(#lua_dir + 2, -5)
    if not rel:match("/_") then
      local mod = rel:gsub("/init$", ""):gsub("/", ".")
      local ok, spec = pcall(require, mod)
      if not ok then
        vim.notify("Error loading " .. mod .. ": " .. spec, vim.log.levels.ERROR)
      elseif type(spec) == "table" then
        specs[#specs+1] = spec
      else
        vim.notify(mod .. " did not return a spec table", vim.log.levels.WARN)
      end
    end
  end
  return specs
end

return M
