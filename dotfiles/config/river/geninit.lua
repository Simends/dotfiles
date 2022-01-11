#!/usr/bin/lua

--[[

Example:

    RIVERCONF_DEVICE="laptop" ./geninit.lua > init && chmod +x init

]]--

local path = os.getenv("XDG_CONFIG_HOME") .. "/river/lua/?.lua"
package.path = path
local conf = require("conf")
local util = require("util")
print('#!/bin/sh\n')

-- Configure mappings
local tag = 0
for i = 1, 9, 1
do
    tag = tostring(math.floor(2^(i - 1)))
    util.mapKey(i, "set-focused-tags " .. tag, conf.mod)
    util.mapKey(i, "set-view-tags " .. tag, conf.mod, "Shift")
    util.mapKey(i, "toggle-focused-tags " .. tag, conf.mod, "Control")
    util.mapKey(i, "toggle-view-tags " .. tag, conf.mod, "Shift+Control")
end

util.mapKeyTable(conf.maps, conf.mod)
util.mapKeyTable(conf.noModMaps, "None")
util.sendCmdTable(conf.sets)
util.configInputs(conf.input_devices)
util.mapKey("F10", "enter-mode normal", conf.mod, nil, "passthrough")

local stacktileopts = "--per-tag-config"
local layout = conf.default_layout

stacktileopts = stacktileopts .. " --primary-count " .. layout.primary.count
stacktileopts = stacktileopts .. " --primary-sublayout " .. layout.primary.sublayout
stacktileopts = stacktileopts .. " --primary-position " .. layout.primary.position
stacktileopts = stacktileopts .. " --primary-ratio " .. layout.primary.ratio
stacktileopts = stacktileopts .. " --secondary-count " .. layout.secondary.count
stacktileopts = stacktileopts .. " --secondary-sublayout " .. layout.secondary.sublayout
stacktileopts = stacktileopts .. " --secondary-ratio " .. layout.secondary.ratio
stacktileopts = stacktileopts .. " --remainder-sublayout " .. layout.remainder.sublayout
stacktileopts = stacktileopts .. " --outer-padding " .. layout.padding.outer
stacktileopts = stacktileopts .. " --inner-padding " .. layout.padding.inner
print('stacktile ' .. stacktileopts)
