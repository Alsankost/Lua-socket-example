<h1> Lua-socket example</h1>

<h2><b>Run:</b></h2>
<ul>
	<li>Install luarocks</li>
	<li>Install Lua-cocket: <i>luarocks lua-socket</i></li>
	<li>Go to project directory: <i>cd path_to_this_project</i></li>
	<li>Run server: <i>lua ./src/server.lua your_port</i></li>
	<li>Run client: <i>lua ./src/client.lua server_ip server_port</i></li>
	<li>Use comman :)</li>
</ul>

<h2><b>Commands:</b></h2>
<ul>
	<li><b>set</b> key data - set data in to server RAM for key</li>
	<li><b>get</b> key - get data the server RAM from key</li>
	<li><b>del</b> key - delete data the server RAM from key</li>
	<li><b>list</b> - show all saved data list from server RAM</li>
	<li><b>stop</b> - shutdown server program</li>
	<li><b>exit</b> - exit the client</li>
</ul>