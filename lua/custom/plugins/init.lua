-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'stevearc/conform.nvim',
    -- load early so you can format on save right away
    event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },

    -- Put the JS/TS indent override here so it always applies
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'javascript',
          'javascriptreact',
          'json',
          'typescript',
          'typescriptreact',
          'ruby',
          'java',
          'python',
          'sh',
          'sql',
          'lua',
        },
        callback = function(args)
          local bo = vim.bo[args.buf]
          bo.shiftwidth = 2
          bo.tabstop = 2
          bo.softtabstop = 2
          bo.expandtab = true
        end,
      })
    end,

    -- pass your configuration straight through to require("conform").setup()
    opts = {
      -- map filetypes to formatter chains
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', 'js_beautify', stop_after_first = true },
        avascriptreact = { 'prettierd', 'prettier', 'js_beautify', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', 'js_beautify', stop_after_first = true },
        ruby = { 'rubocop' },
        python = { 'black' },
        java = { 'google-java-format' },
        sh = { 'shfmt' },
        sql = { 'sql-formatter', 'pg_format', stop_after_first = true },
        csv = { 'prettier' },
        -- add more as needed...
      },
      -- automatically format on save (with a 500 ms timeout)
      format_on_save = {
        timeout_ms = 50000,
        lsp_format = 'fallback',
      },

      formatters = {
        ['sql-formatter'] = {
          command = 'sql-formatter',
          args = { '-l', 'postgresql' },
          stdin = true,
        },
        shfmt = { prepend_args = { '-i', '2' } },
      },
    },
  },
  {
    'katsarosi/jpp_search.nvim',
    name = 'jpp-search.nvim',
    ft = { 'json', 'jsonc' },
    version = '*',
    opts = {
      target = 'float', -- "quickfix" | "float" | "telescope"
      flags = { '-p' },
    },
  },
  --{
  --  "rest-nvim/rest.nvim",
  --  build = false,
  --  dependencies = {
  --    {
  --      "nvim-treesitter/nvim-treesitter",
  --      opts = function(_, opts)
  --        opts.ensure_installed = opts.ensure_installed or {}
  --       table.insert(opts.ensure_installed, "http")
  --      end,
  --    },
  --  },
  --}
}
