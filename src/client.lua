local arg = {...};

local socket = require("socket");
host = host or "localhost";
port = port or 54123;
if arg then
	host = arg[1] or host
	port = arg[2] or port
end
print("Attempting connection to host '" ..host.. "' and port " ..port.. "...");
c = assert(socket.connect(host, port));
c:settimeout(0.5);
print("Connected!")

while true do
	io.write("> ");
	local text = io.read();
	if text == "exit" then
		c:close();
		os.exit(0);
	end;
	c:send(text..'\n');
	local req, e = c:receive();
	while not e do
		if req then
			if req:len() > 1 then
				io.write(req..'\n');
			end;
		end;
		req, e = c:receive();
	end;
	if e == "closed" then
		io.write("Server is closed.\n");
		os.exit(1);
	end;
end;