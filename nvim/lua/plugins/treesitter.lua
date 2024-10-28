require 'nvim-treesitter.configs'.setup{
	ensure_installed = {"lua", "go", "rust", "python", "asm", "bash", "bibtex", "c", "cpp", "cmake", "css", "html","dockerfile", "markdown", "todotxt"}, 
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}
