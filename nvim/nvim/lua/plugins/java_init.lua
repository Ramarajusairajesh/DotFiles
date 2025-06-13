return {
	"nvim-java/nvim-java",
	config = false,
	dependencies = {
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					-- Your JDTLS configuration goes here
					jdtls = {
						-- You can uncomment and customize settings if needed
						-- settings = {
						--   java = {
						--     configuration = {
						--       runtimes = {
						--         {
						--           name = "JavaSE-23",
						--           path = "/usr/local/sdkman/candidates/java/23-tem",
						--         },
						--       },
						--     },
						--   },
						-- },
					},
				},
				setup = {
					jdtls = function()
						require("java").setup({
							-- Customize root markers if needed
							-- root_markers = {
							--   "settings.gradle",
							--   "settings.gradle.kts",
							--   "pom.xml",
							--   "build.gradle",
							--   "mvnw",
							--   "gradlew",
							--   "build.gradle",
							--   "build.gradle.kts",
							-- },
						})
					end,
				},
			},
		},

		-- Add nvim-dap dependency for debugging support
		{
			"mfussenegger/nvim-dap",
			config = function()
				local dap = require("dap")

				dap.adapters.java = {
					type = "server",
					host = "127.0.0.1",
					port = 5005,
				}

				dap.configurations.java = {
					{
						type = "java",
						request = "attach",
						name = "Debug (Attach)",
						hostName = "127.0.0.1",
						port = 5005,
					},
				}
			end,
		},
	},
}
