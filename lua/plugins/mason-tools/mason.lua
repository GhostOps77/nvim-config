-- lsp stuff

return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  opts = {
    ensure_installed = {
      -- lua stuff
      "lua-language-server",
      "stylua",
  
      -- web dev stuff
      -- "css-lsp",
      -- "html-lsp",
      -- "typescript-language-server",
      -- "deno",
      -- "prettier",
  
      -- c/cpp stuff
      -- "clangd",
      -- "clang-format",
  
      -- python stuff
      -- "pyright",
      -- "ruff",
      -- "ruff_lsp"
    },
    -- not an option from mason.nvim
  
    PATH = "skip",
  
    ui = {
      icons = {
        package_pending = " ",
        package_installed = "󰄳 ",
        package_uninstalled = " 󰚌",
      },
  
      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
    },
    max_concurrent_installers = 10,
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "mason")

    -- custom nvchad cmd to install all mason binaries listed
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end
}
