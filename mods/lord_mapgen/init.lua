minetest.register_alias("mapgen_stone",					"default:stone")
minetest.register_alias("mapgen_water_source",			"default:water_source")
minetest.register_alias("mapgen_river_water_source",	"default:water_source")
minetest.register_alias("mapgen_lava_source",			"default:lava_source")

SEED = 0

minetest.register_on_mapgen_init(function(mgparams)
	local new_mgparams = mgparams
	new_mgparams.mgname = "v7"
--	new_mgparams.seed = "narrnika"
	new_mgparams.flags = "notrees, caves, nodungeons, noflat, light"
	minetest.set_mapgen_params(new_mgparams)
	SEED = new_mgparams.seed
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
	local delta = maxp.x-minp.x+1
	if maxp.y < 0 then return end -- верхняя точка ниже 0 - не обрабатываем
	if minp.y > delta then return end -- нижняя точка выше 80 (размер сген.области) - не обрабатываем
	local heightmap = minetest.get_mapgen_object("heightmap")
	local sum, max_h, min_h = 0, -32000, 32000
	for i, j in pairs(heightmap) do -- вычисляем наибольшую/наименьшую высоты
		sum = sum + j
		max_h = math.max(max_h, j)
		min_h = math.min(min_h, j)
	end
	local delta_h, middle_h = max_h-min_h, sum/#heightmap -- разницу высот и среднюю высоту по области
	if middle_h == -31000 then return end -- средняя высота -31000 - в области нет поверхности - не обрабатываем
	print(
		"generated"..": min = "..minetest.pos_to_string(minp)
		..",\tmax = "..minetest.pos_to_string(maxp)
		..",\tmin_h = "..tostring(min_h)
		..",\tmax_h = "..tostring(max_h)
		..",\tdelta_h = "..tostring(delta_h)
		..",\tmiddle_h = "..tostring(middle_h)
	)
--	перевод карты высот в матрцу 80x80
	local heightmap2d = {}
	for x = 1, delta do
		heightmap2d[x] = {}
		for z = 1, delta do
			heightmap2d[x][z] = heightmap[(z-1)*delta+x]
		end
	end
	
--[[замещение блоков "на поверхности"
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			local y = heightmap2d[x-minp.x+1][z-minp.z+1]
			if y ~= -31000 and y~=maxp.y then
				minetest.set_node({['x']=x, ['y']=y, ['z']=z}, {name="default:nyancat_rainbow"})
			end
		end
	end
]]--
	
	local places = {}
	for i = 0, 3 do
		for j = 0, 3 do
			local max_y, min_y = -32000, 32000
			for x = i*20+1, i*20+20 do
				for z = j*20+1, j*20+20 do
					if heightmap2d[x][z] > max_y then max_y = heightmap2d[x][z] end
					if heightmap2d[x][z] < min_y then min_y = heightmap2d[x][z] end
				end
			end
			if (max_y-min_y < 3)and(max_y ~= maxp.y)and(min_y > 0) then
				local x, z = i*20+10, j*20+10
				table.insert(places, {x = x+minp.x, y = heightmap2d[x][z], z = z+minp.z})
			end
		end
	end
	if #places > 0 then
		pos = places[math.random(1, #places)]
		if minetest.get_node(pos).name == "lottmapgen:angsnowblock" then
			minetest.place_schematic(
				{x = pos.x-10, y = pos.y, z = pos.z-10},
				minetest.get_modpath("lord_mapgen").."/schems/angmarfort.mts",
				"random",
				{},
				true
			)
		elseif minetest.get_node(pos).name == "lottmapgen:mirkwood_grass" then
			minetest.place_schematic(
				{x = pos.x-10, y = pos.y, z = pos.z-10},
				minetest.get_modpath("lord_mapgen").."/schems/mirkhouse.mts",
				"random",
				{},
				true
			)
		elseif minetest.get_node(pos).name == "lottmapgen:gondor_grass" then
			minetest.place_schematic(
				{x = pos.x-10, y = pos.y, z = pos.z-10},
				minetest.get_modpath("lord_mapgen").."/schems/gondorfort.mts",
				"random",
				{},
				true
			)
		elseif minetest.get_node(pos).name == "lottmapgen:shire_grass" then
			minetest.place_schematic(
				{x = pos.x-10, y = pos.y, z = pos.z-10},
				minetest.get_modpath("lord_mapgen").."/schems/hobbithole.mts",
				"random",
				{},
				true
			)
		elseif minetest.get_node(pos).name == "lottmapgen:rohan_grass" then
			minetest.place_schematic(
				{x = pos.x-10, y = pos.y, z = pos.z-10},
				minetest.get_modpath("lord_mapgen").."/schems/rohanfort.mts",
				"random",
				{},
				true
			)
		elseif minetest.get_node(pos).name == "lottmapgen:lorien_grass" then
			minetest.place_schematic(
				{x = pos.x-10, y = pos.y, z = pos.z-10},
				minetest.get_modpath("lord_mapgen").."/schems/mallornhouse.mts",
				"random",
				{},
				true
			)
		elseif minetest.get_node(pos).name == "lottmapgen:mordor_stone" then
			minetest.place_schematic(
				{x = pos.x-10, y = pos.y, z = pos.z-10},
				minetest.get_modpath("lord_mapgen").."/schems/orcfort.mts",
				"random",
				{},
				true
			)
		end
	end

--[[замещение блоков "на поверхности" (без 2d преобразования)
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			local y = heightmap[(z-minp.z)*80+(x-minp.x+1)]
			if y ~= -31000 and y~=maxp.y then
				minetest.set_node({['x']=x, ['y']=y, ['z']=z}, {name="default:nyancat_rainbow"})
			end
		end
	end
]]--
--[[ пометка уголв чанка
	minetest.set_node({x=minp.x, y=heightmap[00*80+1], z=minp.z}, {name="default:nyancat_rainbow"})
	minetest.set_node({x=maxp.x, y=heightmap[00*80+80], z=minp.z}, {name="default:nyancat_rainbow"})
	minetest.set_node({x=minp.x, y=heightmap[79*80+1], z=maxp.z}, {name="default:nyancat_rainbow"})
	minetest.set_node({x=maxp.x, y=heightmap[79*80+80], z=maxp.z}, {name="default:nyancat_rainbow"})
]]--
--[[
	if delta_h < 25 and middle_h > 0 then
		local middle_x, middle_z = (maxp.x+minp.x)/2, (maxp.z+minp.z)/2
		local pos = {['x'] = middle_x, ['y'] = middle_h, ['z'] = middle_z}
		minetest.place_schematic(
			pos,
			minetest.get_modpath("lord_mapgen").."/schems/gondorfort.mts",
			"random",
			{},
			true
		)
		print("generated building in "..minetest.pos_to_string(pos))
	end
]]--
--[[
	local map3d = {}
	local i = 0
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			i = i + 1
			table.insert(map3d, {["x"] = x, ["y"] = heightmap[i], ["z"] = z})
		end
	end
	for i, j in pairs(map3d) do
--		print(minetest.pos_to_string(j)..""..minetest.get_node(j).name)
	end
]]--
end)


dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."bioms.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."decorations.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."ores.lua")

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
