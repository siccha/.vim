function tabnew_terminal_with_slime_buffer(register_character, debug_file)
    vim.api.nvim_command('tabnew')
    vim.api.nvim_command('tabmove -1')
    start_terminal_open_buffer_and_update_slime(register_character, debug_file)
end

function split_terminal_with_opened_slime_buffer(register_character, debug_file)
    start_terminal_open_buffer_and_update_slime(register_character, debug_file)
end

function start_terminal_open_buffer_and_update_slime(register_character, debug_file)
    register_content = vim.fn.getreg(register_character)
    run = vim.api.nvim_command
    run('terminal ' .. register_content )
    job_id = vim.api.nvim_exec('echo &channel', true)
    vim.g.last_job_id = job_id
    run('sp ' .. debug_file)
    run('resize 20')
    -- vimscript of next line: let b:slime_config = {"jobid": job_id}
    vim.b.slime_config = {jobid = job_id}
    -- TODO Add hook to close the scratch.py window when the Start-ed terminal is closed.
end

-- Function to: switch to cr-cli, if not term: {close buffer, bdel cr-cli, open terminal, :file cr-cli}
-- map to <leader>bc
