local module = {}

local modulefuncs = {}

module.__index = modulefuncs
modulefuncs.__index = modulefuncs

function module:Init(script, Data)
	self = setmetatable({}, modulefuncs)
	
	self.Script = script
	self.StopFlag = false
	self.StoredData = {}
	self.Data = Data
	
	self:HandleData(false)
	
	return self
end

function modulefuncs:HandleData(request)
	if self.Data then
		if not request then
			if type(self.Data) == "table" then
				for Index,Value in pairs(self.Data) do
					if self.StopFlag then break end
					if self.StoredData[Index] then
						print("Duplicate Found")
					elseif not self.StoredData[Index] and Value ~= nil then
						self.StoredData[Index] = Value
					end
				end
				self.StopFlag = true
			elseif type(self.Data) == "string" then
				if self.StoredData[self.Data] then
					warn("Conflicting Data; ", self.Data," Is messing with ", self.StoredData[self.Data.Name])
				else
					self.StoredData[self.Data] = self.Data
				end
			elseif not (type(self.Data) == "table" or type(self.Data) == "string") then
				if self.StoredData[self.Data.Name] then
					warn("Conflicting Data; ", self.Data," Is messing with ", self.StoredData[self.Data.Name])
				else
					self.StoredData[self.Data.Name] = self.Data
				end
			end
		elseif request then
			print(self.Script, "Requested from Server: ", self[self.Data])
		end
	else
		warn("Insufficient Data: ", self.Data, request)
	end
end

return module