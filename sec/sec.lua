local hsteteac = {}

function hsteteac.lua(arg)
	local code, err = load('return ' .. arg, '@sec')

	-- if failed, try without return
	if err then
		code, err = load(arg, '@sec')
	end

	if err then
		print(err)
		return nil, err
	end

	local status, result = pcall(code)
	print(result)

	if status then
		return result
	end

	return nil, result
end

function hsteteac.js(arg)
	return table.unpack(exports[GetCurrentResourceName()]:runJS(arg))
end

function RunCode(lang, str)
	return hsteteac[lang](str)
end