#!/usr/bin/lua

local M = {}

local sf = string.format
-- local conf = require("conf")

M.sendCmd = function(cmd, param_string)
    local command_str = sf("riverctl %s %s", cmd, param_string or "")
    local result = print(command_str)
    return result
end

M.mapKey = function(key, cmd, modifier, additionalModifier, mode)
    -- local modifier = conf.mod
    if not modifier then
        modifier = "None"
    end
    if additionalModifier then
        modifier = sf("%s+%s", modifier, additionalModifier)
    end
    if not mode then
        mode = "normal"
    end
    local command_str = sf("%s %s %s %s", mode, modifier, key, cmd)
    local result = M.sendCmd("map", command_str)
    return result
end

M.mapKeyTable = function(spawnmap, modifier, additionalModifier, mode)
    for key, cmd in pairs(spawnmap) do
        if type(cmd) == "table" then
            if additionalModifier then
                key = sf("%s+%s", additionalModifier, key)
            end
            M.mapKeyTable(cmd, modifier, key, mode)
        else
            M.mapKey(key, cmd, modifier, additionalModifier, mode)
        end
    end
end

M.sendCmdTable = function(cmdlist)
    for cmd, val in pairs(cmdlist) do
        if type(val) == "table" then
            for _, subval in ipairs(val) do
                M.sendCmd(cmd, subval)
            end
        else
            M.sendCmd(cmd, val)
        end
    end
end

M.configInputs = function (inputsTable)
    local cmd
    for inputDevice, configs in pairs(inputsTable) do
        for option, val in pairs(configs) do
            cmd = "input " .. inputDevice .. " " .. option
            M.sendCmd(cmd, val)
        end
    end
end

return M
