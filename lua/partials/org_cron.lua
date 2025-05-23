-- Load orgmode cron for optimised notifications
local orgmode = vim.fn.stdpath('data') .. '/lazy/orgmode'
vim.opt.runtimepath:append(orgmode)

require('orgmode').cron({
  org_agenda_files = '~/documents/notes/orgfiles/**/*',
  org_default_notes_file = '~/documents/notes/orgfiles/refile.org',
  notifications = {
    reminder_time = { 0, 5, 10 },
  },
})
