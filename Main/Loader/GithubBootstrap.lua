-- GithubRequire bootstrap
local HttpService = game:GetService("HttpService")
local BASE_URL = "https://raw.githubusercontent.com/OceanUltimate/OceanHub/main/"
local cache = {}

-- Install global GithubRequire for loadstring-executed modules
_G.GithubRequire = function(path)
    if type(path) ~= "string" then error("GithubRequire: path must be string") end
    if cache[path] then return cache[path] end

    local ok, src = pcall(function()
        return HttpService:GetAsync(BASE_URL .. path)
    end)
    if not ok then
        error("GithubRequire: failed to GET " .. tostring(path) .. " - " .. tostring(src))
    end

    local fn, compileErr = loadstring(src)
    if not fn then
        error("GithubRequire: compile error for " .. tostring(path) .. " - " .. tostring(compileErr))
    end

    local okRun, result = pcall(fn)
    if not okRun then
        error("GithubRequire: runtime error for " .. tostring(path) .. " - " .. tostring(result))
    end

    cache[path] = result
    return result
end

print("GithubRequire installed (BASE_URL=", BASE_URL, ")")
