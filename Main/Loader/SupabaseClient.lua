local SupabaseClient = {}

local SUPABASE_URL = "https://YOUR_PROJECT.supabase.co"
local SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY"
local LOADER_SCRIPT_URL = SUPABASE_URL .. "/storage/v1/object/public/oceanhub/loader.lua"
local PREMIUM_KEY_TABLE = SUPABASE_URL .. "/rest/v1/premium_keys"

local HttpService = game:GetService("HttpService")

local function httpGet(url, headers)
    headers = headers or {}

    if type(gethttp) == "function" then
        return gethttp(url, headers)
    end

    if type(syn) == "table" and type(syn.request) == "function" then
        local response = syn.request({
            Url = url,
            Method = "GET",
            Headers = headers
        })
        return response.Body
    end

    if type(request) == "function" then
        local response = request({
            Url = url,
            Method = "GET",
            Headers = headers
        })
        return response.Body
    end

    if HttpService and HttpService.HttpEnabled then
        return HttpService:GetAsync(url, true)
    end

    return nil
end

-- Fetch remote loader script. Optional `url` param allows raw GitHub URLs.
function SupabaseClient.FetchRemoteLoaderScript(url)
    local targetUrl = url or LOADER_SCRIPT_URL

    -- Try exploit/runtime-specific fast HTTP helpers first (game:HttpGet if available)
    local fetched
    local ok, err

    ok, err = pcall(function()
        if type(game) == "table" and type(game.HttpGet) == "function" then
            fetched = game:HttpGet(targetUrl)
        end
    end)

    if not fetched then
        local success, result = pcall(httpGet, targetUrl, {
            ["apiKey"] = SUPABASE_ANON_KEY,
            ["Authorization"] = "Bearer " .. SUPABASE_ANON_KEY
        })
        if success and type(result) == "string" and result ~= "" then
            fetched = result
        end
    end

    if type(fetched) ~= "string" or fetched == "" then
        return false, "Unable to fetch remote loader script from " .. tostring(targetUrl)
    end

    local loaderFunction, compileError = loadstring(fetched)
    if not loaderFunction then
        return false, "Remote loader compile failed: " .. tostring(compileError)
    end

    local okRun, runtimeError = pcall(loaderFunction)
    return okRun, runtimeError
end

function SupabaseClient.ValidatePremiumKey(key)
    if type(key) ~= "string" or key == "" then
        return false, "Premium key tidak boleh kosong"
    end

    local url = PREMIUM_KEY_TABLE .. "?select=*&key=eq." .. HttpService:UrlEncode(key)
    local response = httpGet(url, {
        ["apikey"] = SUPABASE_ANON_KEY,
        ["Authorization"] = "Bearer " .. SUPABASE_ANON_KEY,
        ["Content-Type"] = "application/json"
    })

    if type(response) ~= "string" or response == "" then
        -- Fallback local validation if Supabase tidak tersedia.
        return key:match("^OCEANHUB%-%w+") ~= nil, "Fallback validation"
    end

    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, response)
    if not ok then
        return false, "Failed decode Supabase response"
    end

    if type(decoded) == "table" and #decoded > 0 then
        return true, decoded
    end

    return false, "Key tidak ditemukan"
end

function SupabaseClient.GetConfig()
    return {
        SupabaseUrl = SUPABASE_URL,
        SupabaseKey = SUPABASE_ANON_KEY,
        LoaderScriptUrl = LOADER_SCRIPT_URL
    }
end

return SupabaseClient
