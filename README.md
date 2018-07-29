<h1> Lua-socket example</h1>

<h2><b>Run:</b></h2>
<ul>
	<li>Install <a href="https://luarocks.org/"><b>luarocks</b></a></li>
	<li>Install <b>Lua-socket</b>: <u>luarocks lua-socket</u></li>
	<li>Go to project directory: <u>cd path_to_this_project</u></li>
	<li>Run server: <u>lua ./src/server.lua your_port</u></li>
	<li>Run client: <u>lua ./src/client.lua server_ip server_port</u></li>
	<li>Use commands :)</li>
</ul>

<h2><b>Commands:</b></h2>
<ul>
	<li><b>set</b> key data - set data in to server`s RAM for key</li>
	<li><b>get</b> key - get data from the server`s RAM by key</li>
	<li><b>del</b> key - delete data from the server`s RAM by key</li>
	<li><b>list</b> - show all saved data list from the server`s RAM</li>
	<li><b>stop</b> - shutdown server`s program</li>
	<li><b>exit</b> - exit the client</li>
</ul>