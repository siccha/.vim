function start_and_open_scratch_and_set_slime(register_character)
    register_content = vim.fn.getreg(register_character)
    run = vim.api.nvim_command
    run('tabnew')
    run('tabmove -1')
    run('terminal ' .. register_content )
    job_id = vim.api.nvim_exec('echo &channel', true)
    vim.g.last_job_id = job_id
    run('sp scratch.py')
    -- vimscript of next line: let b:slime_config = {"jobid": job_id}
    vim.b.slime_config = {jobid = job_id}
    -- TODO Add hook to close the scratch.py window when the Start-ed terminal is closed.
end
