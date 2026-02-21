-- Run python programs in split terminal
local function run_python(focus_terminal)
	local python_cmd = "python3 " .. vim.fn.expand("%") .. "\n"
	local term_buf = nil
	local term_win = nil

	-- Find existing terminal
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			term_buf = buf
			term_win = win
			break
		end
	end

	if term_buf then
		local job = vim.b[term_buf].terminal_job_id
		if job then
			vim.fn.chansend(job, "clear\n")
			vim.fn.chansend(job, python_cmd)
			if focus_terminal and term_win then
				vim.api.nvim_set_current_win(term_win)
			end
			return
		end
	end

	-- No terminal exists; create a new split terminal
	vim.cmd("split | terminal")
	term_win = vim.api.nvim_get_current_win()
	term_buf = vim.api.nvim_get_current_buf()

	-- Keep buffer around when hidden
	vim.bo[term_buf].bufhidden = "hide"

	-- Send Python command
	local job = vim.b[term_buf].terminal_job_id
	if job then
		vim.fn.chansend(job, python_cmd)
	end

	if focus_terminal then
		vim.api.nvim_set_current_win(term_win)
	else
		-- Return to previous window
		vim.cmd("wincmd h")
	end
end

-- Keymaps
vim.keymap.set("n", "<leader>r", function()
	run_python(false)
end, { desc = "Run Python file" })
