--Created by Krock
--License: WTFPL

if(bitchange_use_quartz) then
if(core.get_modpath("quartz")) then
	core.register_craft({
		output = "bitchange:coinbase",
		recipe = {
			{"quartz:quartz_crystal", "default:pick_diamond"},
			{"quartz:quartz_crystal", "quartz:quartz_crystal"},
			{"quartz:quartz_crystal", "quartz:quartz_crystal"}
		},
		replacements = { {"default:pick_diamond", "default:pick_diamond"} },
	})
else
	print("[BitChange] Error: quartz support disabled, missing mod: 'quartz'"
end
end
