-- Copyright 2019 X-WRT <dev@x-wrt.com>
-- Copyright 2022-2024 sirpdboy

module("luci.controller.netwizard", package.seeall)
function index()
	if not nixio.fs.access("/etc/config/netwizard") then return end
	if not nixio.fs.access("/etc/config/netwizard_hide") then
	        e = entry({"admin", "system", "netwizard"}, cbi("netwizard/netwizard"), _("Netwizard"), 1)
		e.dependent = true
                e.acl_depends = { "luci-app-netwizard" }
	end
end
