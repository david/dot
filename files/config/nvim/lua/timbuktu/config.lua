-- [nfnl] files/config/nvim/fnl/timbuktu/config.fnl
local function kv(...)
  local args = {...}
  _G.assert((nil ~= args), "Missing argument args on /var/home/david/Homes/dot/dot/files/config/nvim/fnl/timbuktu/config.fnl:1")
  local hashmap = {}
  local sequential = {}
  for _, val in ipairs(args) do
    if (type(val) == "table") then
      hashmap = vim.tbl_extend("force", hashmap, val)
    else
    end
  end
  for _, val in ipairs(args) do
    if (type(val) ~= "table") then
      table.insert(sequential, val)
    else
    end
  end
  return vim.tbl_extend("force", sequential, hashmap)
end
local function setup(repo_or_spec, _3fspec)
  _G.assert((nil ~= repo_or_spec), "Missing argument repo-or-spec on /var/home/david/Homes/dot/dot/files/config/nvim/fnl/timbuktu/config.fnl:12")
  local _3_ = {repo_or_spec, _3fspec}
  local and_4_ = ((_G.type(_3_) == "table") and (nil ~= _3_[1]) and (_3_[2] == nil))
  if and_4_ then
    local repo = _3_[1]
    and_4_ = (type(repo) == "string")
  end
  if and_4_ then
    local repo = _3_[1]
    return {repo}
  else
    local and_6_ = ((_G.type(_3_) == "table") and (nil ~= _3_[1]) and (_3_[2] == nil))
    if and_6_ then
      local spec = _3_[1]
      and_6_ = (type(spec) == "table")
    end
    if and_6_ then
      local spec = _3_[1]
      return spec
    elseif ((nil ~= _3_[1]) and (nil ~= _3_[2])) then
      local repo = _3_[1]
      local spec = _3_[2]
      return kv(repo, spec)
    else
      return nil
    end
  end
end
return {kv = kv, setup = setup}
