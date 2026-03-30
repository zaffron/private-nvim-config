local function get_workspace_folder()
	local root = vim.fn.getcwd()
	return {
		name = vim.fn.fnamemodify(root, ":t"),
		uri = vim.uri_from_fname(root),
	}
end

return {
	cmd = { "/home/zaffron/.local/share/nvim/mason/bin/vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		"package.json",
		".git",
	},
	settings = {
		workspaceFolder = get_workspace_folder(),
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
		validate = "on",
		run = "onType",
		format = true,
		onIgnoredFiles = "off",
		problems = {
			shortenToSingleLine = false,
		},
		rulesCustomization = {},
		useEslintClass = false,
		nodePath = "",
		experimental = {
			useFlatConfig = false,
		},
		packageManager = "npm",
		codeActionOnSave = {
			enable = true,
			mode = "all",
		},
	},
}
