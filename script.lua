local v0 = (17455 - (191 + 1100)) + (((2985 + 879 + (365058 - (892 + 65))) - (68686 + 205710)) - 67600) + (190952 - (17401 + 93237));
v0 = v0 + ((990 - (282 + 595)) - ((47 - 21) + (122 - 55))) + ((1569 - (87 + 263)) - ((299 - (67 + 113)) + (2634 - (1523 + 114))));
local v1 = 2954681 - 1751225;
local v2 = 1105775 + 124696;
local v3 = 8023481;
if (v2 > v1) then
	print("true");
end
if ((1 + 0 + v3) > v2) then
	print("obfuscate the conditions!");
end
print("Clicking [Strings] will completely hide this string!");
do
	function sieve_of_eratosthenes(v5)
		local v6 = 0 - 0;
		local v7;
		while true do
			if ((0 - 0) == v6) then
				v7 = {};
				for v10 = 1066 - (68 + 997), v5 do
					v7[v10] = (1271 - (226 + 1044)) ~= v10;
				end
				v6 = 4 - 3;
			end
			if (v6 == (118 - (32 + 85))) then
				for v12 = 2 + 0, math.floor(math.sqrt(v5)) do
					if v7[v12] then
						for v13 = v12 * v12, v5, v12 do
							v7[v13] = false;
						end
					end
				end
				return v7;
			end
		end
	end
	local v4 = sieve_of_eratosthenes(94 + 326);
	for v8, v9 in pairs(v4) do
		if v9 then
			print("Prime found: " .. v8);
		end
	end
end
