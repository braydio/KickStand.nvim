return {
  'Robitx/gp.nvim',
  event = 'VeryLazy',
  config = function()
    local gp = require 'gp'
    local brief_system_prompt = table.concat({
      'You are a focused coding assistant.',
      'Respond concisely and stay well within token limits.',
      'Follow the request exactly and omit extra commentary or unsolicited advice.',
      'Skip explanations unless they are explicitly asked for by the user.',
    }, ' ')
    gp.setup {
      providers = {
        openai = {
          disable = false,
          endpoint = 'https://api.openai.com/v1/chat/completions',
          secret = os.getenv 'OPENAI_API_KEY',
        },
        ollama = {
          disable = false,
          endpoint = 'http://192.168.1.69:5150/v1/chat/completions',
          secret = 'dummy secret',
        },
      },
      cmd_prefix = 'Gp',
      curl_params = { 'proxy', 'http://localhost:8080' },
      -- Store logs outside the repo and redact sensitive values
      log_file = vim.fn.stdpath('state') .. '/gp.nvim.log',
      log_sensitive = true,

      agents = {
        {
          provider = 'openai',
          name = 'ChatGPT4.1',
          chat = true,
          command = false,
          model = { model = 'gpt-4.1', temperature = 1.1, top_p = 1 },
          system_prompt = 'You are a helpful assistant.',
        },
        {
          provider = 'openai',
          name = 'ChatGPT4.1-nano',
          chat = true,
          command = false,
          model = { model = 'gpt-4.1-nano', temperature = 1.1, top_p = 1 },
          system_prompt = 'You are a helpful assistant.',
        },
        {
          provider = 'openai',
          name = 'CodeGPT-o3-mini',
          chat = false,
          command = true,
          model = { model = 'o3-mini', temperature = 0.8, top_p = 1 },
          system_prompt = require('gp.defaults').code_system_prompt,
        },
      },

      system_prompt = 'You are a helpful coding assistant',

      hooks = {
        BriefChat = function(gp, params)
          gp.cmd.ChatNew(params, brief_system_prompt)
        end,
      },

      templates = {
        rewrite = {
          ReviewCode = {
            prompt = [[
Please review the following code block. Identify any errors or corrections that should be implemented, and describe them in brief comments or docstrings.

{{selection}}

Respond with the corrected code. Include *only* the corrected code in your response and nothing else.
]],
          },
          RefactorCode = {
            prompt = [[
Refactor the following code to improve readability, performance, and maintainability. Keep behavior the same.

{{selection}}

Return only the refactored code.
]],
          },
          ExplainCode = {
            prompt = [[
Explain what the following code does, line by line.

{{selection}}

Write the explanation in plain English for someone new to this language.
]],
          },
          CommentCode = {
            prompt = [[
Add helpful comments to the following code to clarify its purpose.

{{selection}}

Return only the updated code with comments.
]],
          },
          AddTypes = {
            prompt = [[
Add appropriate type annotations to the following code, based on standard typing practices for the language.

{{selection}}

Return only the updated code.
]],
          },
          FormatMarkdown = {
            prompt = [[
Rewrite the selection in markdown formatted syntax. Fix grammar, spelling, and punctuation as needed:

{{selection}}

Return only the rewritten content. Do not include any explanations, prefaces, or extra detail.
]],
          },
        },
        utils = {
          Docstringify = {
            prompt = [[
Create a clear, concise docstring for the following code. Include parameter and return descriptions where appropriate. Keep the style idiomatic for the language.

{{selection}}

Return only the updated code with the docstring added.
]],
          },
          UnitTest = {
            prompt = [[
Write unit tests for the following code. Use common testing frameworks for the language. Focus on edge cases and clear assertions.

{{selection}}

Return only the test code.
]],
          },
          CommitMessage = {
            prompt = [[
Generate a concise, conventional commit message (type(scope): summary) summarizing the following diff or description:

{{selection}}

Return only the commit message line(s).
]],
          },
        },
      },
    }

    -- Keymaps (outside gp.setup)
    -- Open new chats in a split so they don't take over the entire screen
    vim.keymap.set('n', '<leader>gn', '<Cmd>vsplit | GpChatNew<CR>', { desc = 'GP: New chat (vsplit)' })
    vim.keymap.set('n', '<leader>gB', '<Cmd>vsplit | GpBriefChat<CR>', { desc = 'GP: New brief chat (vsplit)' })
    vim.keymap.set('n', '<leader>ga', '<Cmd>GpNextAgent<CR>', { desc = 'GP: Next agent' })
    vim.keymap.set(
      'v',
      '<leader>gn',
      ':<C-u>GpChatNew vsplit<CR>',
      { desc = 'GP: New chat with selection (vsplit)' }
    )
    vim.keymap.set(
      'v',
      '<leader>gr',
      ':<C-u>GpRewrite ReviewCode<CR>',
      { desc = 'GP: Review code' }
    )
    vim.keymap.set(
      'v',
      '<leader>gf',
      ':<C-u>GpRewrite RefactorCode<CR>',
      { desc = 'GP: Refactor code' }
    )
    vim.keymap.set(
      'v',
      '<leader>ge',
      ':<C-u>GpRewrite ExplainCode<CR>',
      { desc = 'GP: Explain code' }
    )
    vim.keymap.set(
      'v',
      '<leader>gc',
      ':<C-u>GpRewrite CommentCode<CR>',
      { desc = 'GP: Add comments' }
    )
    vim.keymap.set(
      'v',
      '<leader>gm',
      ':<C-u>GpRewrite FormatMarkdown<CR>',
      { desc = 'GP: Markdown format' }
    )
    vim.keymap.set(
      'v',
      '<leader>gt',
      ':<C-u>GpRewrite AddTypes<CR>',
      { desc = 'GP: Add type annotations' }
    )
    vim.keymap.set(
      'v',
      '<leader>gB',
      ':<C-u>GpBriefChat vsplit<CR>',
      { desc = 'GP: Brief chat (vsplit)' }
    )

    -- Optional: Docstring utility
    vim.keymap.set(
      'v',
      '<leader>gd',
      ':<C-u>GpRewrite Docstringify<CR>',
      { desc = 'GP: Add docstring' }
    )
    -- Optional: Generate tests utility
    vim.keymap.set(
      'v',
      '<leader>gT',
      ':<C-u>GpRewrite UnitTest<CR>',
      { desc = 'GP: Generate unit tests' }
    )
    -- Optional: Commit message helper from selected text/diff
    vim.keymap.set(
      'v',
      '<leader>gM',
      ':<C-u>GpRewrite CommitMessage<CR>',
      { desc = 'GP: Commit message' }
    )
  end,
}
