local workspace = game:GetService("Workspace")

local table = {[script.Name] = script, [workspace.Name] = workspace}

local scriptmodule = require(script.ModuleScript):Init(script, script)
local tablemodule = require(script.ModuleScript):Init(script, table)

print(scriptmodule.StoredData)
print(tablemodule.StoredData)