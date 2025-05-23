-- Load orgmode cron for optimised notifications
local orgmode = vim.fn.stdpath('data') .. '/lazy/orgmode'
vim.opt.runtimepath:append(orgmode)

require('orgmode').cron({
  org_agenda_files = '~/documents/notes/orgfiles/**/*',
  org_default_notes_file = '~/documents/notes/orgfiles/refile.org',
  notifications = {
    enabled = true,
    cron_enabled = true,
    repeater_reminder_time = true,
    deadline_warning_reminder_time = true,
    reminder_time = { 1, 5, 10 },
    deadline_reminder = true,
    scheduled_reminder = true,
  },
})
