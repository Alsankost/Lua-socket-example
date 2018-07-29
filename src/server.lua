local arg = {...};

local socket = require("socket");

local host, port = "*", 54123;

if arg then
	port = arg[1];
end;

local s, g = socket.bind(host, port);
if s == nil then
	io.write(g..'\n');
	os.exit(1);
end;

local i, p = s:getsockname()
print("Waiting connection from client on " .. i .. ":" .. p .. "...");

s:settimeout(0.0001);

local data = {};
local connections = {};
local isOn = true;

local commads = {};
commads["set"] = {
	args = 2,
	func = function(c, args)
		data[args[1]] = args[2];
	end;
}

commads["get"] = {
	args = 1,
	func = function(c, args)
		local d = data[args[1]];
		if d == nil then
			return "empty";
		end;
		return '"'..d..'"';
	end;
}

commads["del"] = {
	args = 1,
	func = function(c, args)
		data[args[1]] = nil;
	end;
}

commads["stop"] = {
	args = 0,
	func = function(c, args)
		isOn = false;
	end;
}

commads["list"] = {
	args = 0,
	func = function(c, args)
		local res = "";
		for key, dn in pairs(data) do
			res = res..' '..key.." = "..'"'..dn..'"'..'\n';
		end;
		return res;
	end;
}

local function comObserver(c, com, args)
	local comI = commads[com];
	if comI == nil then
		return "Unknow commad!";
	end;

	if #args ~= comI.args then
		return "Arguments error! Need "..comI.args.." arguments for '"..com.."' command!";
	end;

	return comI.func(c, args);
end;

local function comParse(data)
	data = data..' ';
	local cs, ce, com = data:find("^%s*(%w+)%s");
	if not(cs) or not(ce) or not(com) then
		return nil;
	end;
	data = ' '..data:sub(ce + 1, data:len());
	local args = {};
	for m in data:gmatch("%s(%w+)") do
		table.insert(args, m);
	end;
	return com, args;
end;

local function showClientInfo(c)
	local ip, port = c:getsockname()
	io.write('['..ip..':'..port.."] ");
end;

local function acceptClient()
	local tc = s:accept();
	if tc then
		io.write("New connection - ");
		showClientInfo(tc);
		io.write('\n');
		tc:settimeout(0.01);
		table.insert(connections, tc);
	end;
end;

while isOn do
	acceptClient();
	for i = 1, #connections do
		--acceptClient();
		local c = connections[i];

		local data, e = c:receive();
		--print(data);
		if e == "closed" then
			showClientInfo(c);
			io.write("Disconected\n");
			table.remove(connections, i);
			c:close();
		elseif data then
			showClientInfo(c);
			io.write("Execute command: "..data..'\n');
			local req = comObserver(c, comParse(data));
			if type(req) == "string" then
				c:send(req);
			end;
			c:send('\n');
		end;
	end;
end;
s:close();
print("Server is closed.");