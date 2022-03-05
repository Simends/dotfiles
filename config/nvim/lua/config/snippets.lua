local ls = require("luasnip")
local lse = require("luasnip.extras")

local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dyn = ls.dynamic_node
local l = lse.lambda
local rep = lse.rep
local partial = lse.partial
local match = lse.match
local nonemp = lse.nonempty
local dynl = lse.dynamic_lambda
local types = require("luasnip.util.types")

-- Configuration
ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			}
		}
	},
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true
})

ls.snippets = {
	all = {
		snip("signature", {
			text("Simen Dager Sneve"),
			insert(0),
		}),
	},

    sh = {
        snip("binsh", {
            text({"#!/bin/sh", ""}),
            insert(0),
        }),
        snip("binbash", {
            text({"#!/bin/bash", ""}),
            insert(0),
        }),
        snip("binenvbash", {
            text({"#!/usr/bin/env bash", ""}),
            insert(0),
        }),
    },

    python = {
        snip("shebang", {
            text({"#!/usr/bin/env python", ""}),
            insert(0),
        }),
    },

    lua = {
        snip("shebang", {
            text({"#!/usr/bin/lua", "", ""}),
            insert(0),
        }),
        snip("req", {
            text("require('"),
            insert(1, "Module-name"),
            text("')"),
            insert(0),
        }),
        snip("func", {
            text("function("),
            insert(1, "Arguments"),
            text({")", "\t"}),
            insert(2),
            text({"", "end", ""}),
            insert(0),
        }),
        snip("forp", {
            text("for "),
            insert(1, "k"),
            text(", "),
            insert(2, "v"),
            text(" in pairs("),
            insert(3, "table"),
            text({") do", "\t"}),
            insert(4),
            text({"", "end", ""}),
            insert(0),
        }),
        snip("fori", {
            text("for "),
            insert(1, "k"),
            text(", "),
            insert(2, "v"),
            text(" in ipairs("),
            insert(3, "table"),
            text({") do", "\t"}),
            insert(4),
            text({"", "end", ""}),
            insert(0),
        }),
        snip("if", {
            text("if "),
            insert(1),
            text({" then", "\t"}),
            insert(2),
            text({"", "end", ""}),
            insert(0)
        }),
        snip("M", {
            text({"local M = {}", "", ""}),
            insert(0),
            text({"", "", "return M"}),
        }),
    },

    c = {
        snip("#d", {
            text("#define "),
            insert(0),
        }),
        snip("#i", {
            text("#include <"),
            insert(1),
            text({".h>", ""}),
            insert(0),
        }),
        snip("#I", {
            text([[#include "]]),
            insert(1),
            text({[[.h"]], ""}),
            insert(0),
        }),
        snip("#f", {
            text({"#ifdef", ""}),
            insert(1),
            text({"", "#endif", ""}),
            insert(0),
        }),
    },

	markdown = {
		snip("link", {
			text("["),
			insert(1, "Name"),
			text("]("),
			insert(2, "Link"),
			text(")"),
			insert(0),
		}),
        snip("mermaid flowchart", {
            text({"``` mermaid", "graph TD", ""}),
            insert(1, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
        snip("mermaid sequence", {
            text({"``` mermaid", "sequenceDiagram", ""}),
            insert(1, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
        snip("mermaid gantt", {
            text({"``` mermaid", "gantt", ""}),
            insert(1, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
        snip("mermaid class", {
            text({"``` mermaid", "classDiagram", ""}),
            insert(1, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
        snip("mermaid state", {
            text({"``` mermaid", "stateDiagram-v2", ""}),
            insert(1, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
        snip("mermaid piechart", {
            text({"``` mermaid", "pie", ""}),
            insert(1, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
        snip("mermaid journey", {
            text({"``` mermaid", "journey", ""}),
            insert(1, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
        snip("code block", {
            text("``` "),
            insert(1, "Language"),
            text({"", ""}),
            insert(2, "Content"),
            text({"", "```", ""}),
            insert(0),
        }),
	}
}
