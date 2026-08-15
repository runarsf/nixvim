-- https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1690573382

local M = {}

local telescopeUtilities = require('telescope.utils')
local telescopeMakeEntryModule = require('telescope.make_entry')
local plenaryStrings = require('plenary.strings')
local devIcons = require('nvim-web-devicons')
local telescopeEntryDisplayModule = require('telescope.pickers.entry_display')
local telescopePickersModule = require('telescope.pickers')
local telescopeFindersModule = require('telescope.finders')
local telescopeConfigModule = require('telescope.config')
local telescopeActionsModule = require('telescope.actions')
local telescopeActionStateModule = require('telescope.actions.state')
local telescopePreviewersModule = require('telescope.previewers')

-- Obtain Filename icon width
-- --------------------------
-- INSIGHT: This width applies to all icons that represent a file type
local fileTypeIconWidth = plenaryStrings.strdisplaywidth(devIcons.get_icon('fname', { default = true }))

---- Helper functions ----

-- Gets the File Path and its Tail (the file name) as a Tuple
local getPathAndTail = function(fileName)
  -- Get the Tail
  local bufferNameTail = telescopeUtilities.path_tail(fileName)

  -- Now remove the tail from the Full Path
  local pathWithoutTail = plenaryStrings.truncate(fileName, #fileName - #bufferNameTail, '')

  -- Apply truncation and other pertaining modifications to the path according to Telescope path rules
  local pathToDisplay = telescopeUtilities.transform_path({
    path_display = { 'truncate' },
  }, pathWithoutTail)

  -- Return as Tuple
  return bufferNameTail, pathToDisplay
end

-- Supported by: find_files, git_files, oldfiles
M.prettyFilesEntryMaker = function(opts)
  opts = opts or {}
  local originalEntryMaker = telescopeMakeEntryModule.gen_from_file(opts)

  return function(line)
    -- Generate the Original Entry table
    local originalEntryTable = originalEntryMaker(line)

    -- INSIGHT: An "entry display" is an abstract concept that defines the "container" within which data
    --          will be displayed inside the picker, this means that we must define options that define
    --          its dimensions, like, for example, its width.
    local displayer = telescopeEntryDisplayModule.create({
      separator = ' ', -- Telescope will use this separator between each entry item
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { remaining = true },
      },
    })

    -- LIFECYCLE: At this point the "displayer" has been created by the create() method, which has in turn
    --            returned a function. This means that we can now call said function by using the
    --            'displayer' variable and pass it actual entry values so that it will, in turn, output
    --            the entry for display.
    --
    -- INSIGHT: We now have to replace the 'display' key in the original entry table to modify the way it
    --          is displayed.
    -- INSIGHT: The 'entry' is the same Original Entry Table but is is passed to the 'display()' function
    --          later on the program execution, most likely when the actual display is made, which could
    --          be deferred to allow lazy loading.
    --
    -- HELP: Read the 'make_entry.lua' file for more info on how all of this works
    originalEntryTable.display = function(entry)
      -- Get the Tail and the Path to display
      local tail, pathToDisplay = getPathAndTail(entry.value)

      -- Add an extra space to the tail so that it looks nicely separated from the path
      local tailForDisplay = tail .. ' '

      -- Get the Icon with its corresponding Highlight information
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

      -- INSIGHT: This return value should be a tuple of 2, where the first value is the actual value
      --          and the second one is the highlight information, this will be done by the displayer
      --          internally and return in the correct format.
      return displayer({
        { icon,          iconHighlight },
        tailForDisplay,
        { pathToDisplay, 'TelescopeResultsComment' },
      })
    end

    return originalEntryTable
  end
end

-- Supported by: live_grep, grep_string
M.prettyGrepEntryMaker = function(opts)
  local originalEntryMaker = telescopeMakeEntryModule.gen_from_vimgrep(opts)

  return function(line)
    -- Generate the Original Entry table
    local originalEntryTable = originalEntryMaker(line)

    -- INSIGHT: An "entry display" is an abstract concept that defines the "container" within which data
    --          will be displayed inside the picker, this means that we must define options that define
    --          its dimensions, like, for example, its width.
    local displayer = telescopeEntryDisplayModule.create({
      separator = ' ', -- Telescope will use this separator between each entry item
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { width = nil }, -- Maximum path size, keep it short
        { remaining = true },
      },
    })

    -- LIFECYCLE: At this point the "displayer" has been created by the create() method, which has in turn
    --            returned a function. This means that we can now call said function by using the
    --            'displayer' variable and pass it actual entry values so that it will, in turn, output
    --            the entry for display.
    --
    -- INSIGHT: We now have to replace the 'display' key in the original entry table to modify the way it
    --          is displayed.
    -- INSIGHT: The 'entry' is the same Original Entry Table but is is passed to the 'display()' function
    --          later on the program execution, most likely when the actual display is made, which could
    --          be deferred to allow lazy loading.
    --
    -- HELP: Read the 'make_entry.lua' file for more info on how all of this works
    originalEntryTable.display = function(entry)
      ---- Get File columns data ----
      -------------------------------

      -- Get the Tail and the Path to display
      local tail, pathToDisplay = getPathAndTail(entry.filename)

      -- Get the Icon with its corresponding Highlight information
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

      ---- Format Text for display ----
      ---------------------------------

      -- Add coordinates if required by 'options'
      local coordinates = ""

      if not opts.disable_coordinates then
        if entry.lnum then
          if entry.col then
            coordinates = string.format(" %s:%s", entry.lnum, entry.col)
          else
            coordinates = string.format(" %s", entry.lnum)
          end
        end
      end

      -- Append coordinates to tail
      tail = tail .. coordinates

      -- Add an extra space to the tail so that it looks nicely separated from the path
      local tailForDisplay = tail .. ' '

      -- Encode text if necessary
      local text = opts.file_encoding and vim.iconv(entry.text, opts.file_encoding, "utf8") or entry.text

      -- INSIGHT: This return value should be a tuple of 2, where the first value is the actual value
      --          and the second one is the highlight information, this will be done by the displayer
      --          internally and return in the correct format.
      return displayer({
        { icon,          iconHighlight },
        tailForDisplay,
        { pathToDisplay, 'TelescopeResultsComment' },
        text
      })
    end

    return originalEntryTable
  end
end

-- There's no `telescope.builtin` equivalent for `:messages`, so this is a
-- full custom picker rather than just an entry-maker like the ones above.
-- Combines `require('notify').history()` (vim.notify()-routed, structured:
-- title/level/icon/timestamp, possibly multi-line) and `:messages`
-- (echomsg/print-routed, flat single lines, no timestamp) into one picker,
-- since they're disjoint sources (notify overrides `vim.notify`; it never
-- touches `:messages`) and checking both separately is tedious. There's no
-- real timestamp to merge them by for `:messages`, so each source is sorted
-- newest-first internally and notifications are listed before messages.
M.notifications = function(opts)
  opts = opts or {}

  local displayer = telescopeEntryDisplayModule.create({
    separator = ' ',
    items = {
      { width = 2 },
      { width = 10 },
      { remaining = true },
    },
  })

  local entryMaker = function(entry)
    return {
      value = entry,
      ordinal = entry.title .. ' ' .. entry.summary,
      display = function(e)
        return displayer({
          { e.value.icon, 'Notify' .. e.value.level .. 'Title' },
          { e.value.title, 'Notify' .. e.value.level .. 'Title' },
          { e.value.summary, 'Notify' .. e.value.level .. 'Body' },
        })
      end,
    }
  end

  local results = {}

  local ok, notify = pcall(require, 'notify')
  if ok then
    local history = notify.history()
    for i = #history, 1, -1 do
      local notif = history[i]
      table.insert(results, {
        title = notif.title[1] ~= '' and notif.title[1] or 'notify',
        level = notif.level,
        icon = notif.icon,
        summary = notif.message[1],
        full = table.concat(notif.message, '\n'),
      })
    end
  end

  -- `:messages` prints oldest-first; reverse so the most recent is on top
  local lines = vim.split(vim.fn.execute('messages'), '\n')
  for i = #lines, 1, -1 do
    if lines[i] ~= '' then
      table.insert(results, {
        title = 'message',
        level = 'Message',
        icon = '',
        summary = lines[i],
        full = lines[i],
      })
    end
  end

  telescopePickersModule.new(opts, {
    prompt_title = 'Notifications & Messages',
    finder = telescopeFindersModule.new_table({
      results = results,
      entry_maker = entryMaker,
    }),
    sorter = telescopeConfigModule.values.generic_sorter(opts),
    previewer = telescopePreviewersModule.new_buffer_previewer({
      title = 'Message',
      define_preview = function(self, entry)
        vim.api.nvim_win_set_option(self.state.winid, 'wrap', true)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(entry.value.full, '\n'))
      end,
    }),
    attach_mappings = function(prompt_bufnr, _)
      telescopeActionsModule.select_default:replace(function()
        telescopeActionsModule.close(prompt_bufnr)
        local selection = telescopeActionStateModule.get_selected_entry()
        if not selection then
          return
        end

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(selection.value.full, '\n'))
        vim.bo[buf].modifiable = false
        vim.bo[buf].bufhidden = 'wipe'

        vim.cmd.tabnew()
        vim.api.nvim_win_set_buf(0, buf)
      end)
      return true
    end,
  }):find()
end

return M
