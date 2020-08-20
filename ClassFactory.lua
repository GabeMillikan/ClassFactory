local cf = {}

-- just a recursive deep copy that does not set the metatable on the topmost table
function CreateClassInstance(orig, depth, copies)
	copies = copies or {}
	depth = depth or 1
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		if copies[orig] then
			copy = copies[orig]
		else
			copy = {}
			copies[orig] = copy
			for orig_key, orig_value in next, orig, nil do
				copy[CreateClassInstance(orig_key, depth+1, copies)] = CreateClassInstance(orig_value, depth+1, copies)
			end
			if depth > 1 then -- do not copy metatable on class (this will contain the __call constructor, which we dont want)
				setmetatable(copy, CreateClassInstance(getmetatable(orig), copies))
			end
		end
	else
		copy = orig
	end
	return copy
end

function cf:New(className)
	className = className or "unnamed class"
	
	local meta = {}
	local class = {}
	
	meta.className = className
	function meta:__call(...)
		local inst = CreateClassInstance(self)
		setmetatable(inst, {class = class})
		inst:init(...)
		return inst
	end
	
	function class:init()
		print(getmetatable(self).className .. ":init() called... Overwrite me!")
	end
	
	setmetatable(class, meta)
	return class
end

return cf
