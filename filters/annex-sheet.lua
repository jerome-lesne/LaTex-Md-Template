-- Render portable Markdown layout groups for the PDF output.
local environments = {
	["annex-sheet"] = "annexsheet",
	["figure-block"] = "figureblock",
}

function Div(element)
	if not FORMAT:match("latex") then
		return element
	end

	local environment

	for _, class in ipairs(element.classes) do
		if environments[class] then
			environment = environments[class]
			break
		end
	end

	if not environment then
		return element
	end

	local blocks = { pandoc.RawBlock("latex", "\\begin{" .. environment .. "}") }

	for _, block in ipairs(element.content) do
		blocks[#blocks + 1] = block
	end

	blocks[#blocks + 1] = pandoc.RawBlock("latex", "\\end{" .. environment .. "}")
	return blocks
end

-- Let longtable keep a standalone bold label with its header and first row.
-- The Markdown source and non-LaTeX exports retain the explicit labels.
function Blocks(blocks)
	if not FORMAT:match("latex") then
		return blocks
	end

	local result = pandoc.List()
	local index = 1

	while index <= #blocks do
		local label = blocks[index]
		local following = blocks[index + 1]

		if
			label.t == "Para"
			and #label.content == 1
			and label.content[1].t == "Strong"
			and following
			and following.t == "Table"
			and #following.caption.long == 0
		then
			following.caption.long = { pandoc.Plain(label.content) }
			result:insert(following)
			index = index + 2
		else
			result:insert(label)
			index = index + 1
		end
	end

	return result
end
