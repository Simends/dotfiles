local M = {}
local Path = require('plenary.path')
local wikiPath = Path:new{vim.env.HOME .. "/Documents/Wiki"}
local function ensurePath(path)
	if path:exists() == false then
		path:mkdir()
	end
end
local function createFromTemplate(name, path)
	if name ~= nil then
		local fileName = name .. ".md"
		local file = wikiPath:joinpath(".templates", fileName)
		if ((not path:exists()) and file:exists()) then
			vim.loop.fs_copyfile(file:absolute(), path:absolute())
		end
	end
end
local function mkDaily(time)
	-- Takes a date as argument and opens a daily file for it
	local filename = os.date("%d-%m-%Y.md", time)
	local journalPath = wikiPath:joinpath("journal")
	ensurePath(journalPath)
	local filePath = journalPath:joinpath(filename)

	createFromTemplate("daily", filePath)
	vim.cmd("edit journal/" .. filename)
end

M.dailyToday = function()
	-- Creates a daily file for today
	mkDaily(os.time())
end

M.dailyYesterday = function()
	-- Creates a daily file for yesterday
	local date = os.time() - 24 * 3600
	mkDaily(date)
end

M.dailyTomorrow = function()
	-- Creates a daily file for tomorrow
	local date = os.time() + 24 * 3600
	mkDaily(date)
end

M.subDirAdd = function(dir, template, prompt)
	-- Add a file to (read/listen/watch/play)list
	local name = vim.call("input", prompt)
	local filename = name .. ".md"
	local subDirPath = ""
	if not dir then
		subDirPath = wikiPath
	else
		subDirPath = wikiPath:joinpath(dir)
	end
	ensurePath(subDirPath)
	local filePath = subDirPath:joinpath(filename)
	createFromTemplate(template, filePath)
	vim.cmd("edit " .. dir .. "/" .. filename)
end

M.subDirFind = function(dir, prompt)
	local subDirPath = ""
	if not dir then
		subDirPath = wikiPath
	else
		subDirPath = wikiPath:joinpath(dir)
	end
	require('telescope.builtin').find_files({
		prompt_title = prompt,
		cwd = subDirPath:absolute(),
		find_command = { 'fd', '--type', 'f', '-d', '1', '--exclude', '*index.md' }
	})
end

M.notesGrep = function()
	require('telescope.builtin').live_grep({
		prompt_title = "Søk i Notater",
		cwd = wikiPath:absolute()
	})
end

return M
