#!/usr/bin/env lua

--for i,v in pairs(arg) do
--end
local compile_file= arg[1];
local target_file= arg[2];
print("start compile"..compile_file);
local target=io.open(target_file,"w");
local file=io.open(compile_file);
local contex=file:read("*a");
target:write([[
return function(T,fun) 
	local lem_output={};
	local o=function(str)
		table.insert(lem_output,str);
	end
	if fun~=nil then 
		o=fun;
	end
]])
local start=1;
local stop=0;
local status="";
local w=function(str) target:write(str) end;
local quote=function(str) 
	return "[=[","]=]";
end
local o=function(str) local l,r=quote(str);w("o("..l..str..r..");\n"); end
local len=#contex;
local i=1;
while i<=len do
	local si=i;
	if status=="" then
		if string.sub(contex,i,i+2) =="[%=" then
			status="[%=";
			if stop>=start then
				o(string.sub(contex,start,stop));
			end
			start=i;
			stop=i;
			i=i+3;
			start=i;
			w("o(");
		elseif string.sub(contex,i,i+2) =="[%~" then
			status='[%~';
			if stop>=start then
				o(string.sub(contex,start,stop));
			end
			start=i;
			stop=i;
			i=i+3;
			start=i;
		elseif  string.sub(contex,i,i+1)=="[%" then
			status='[%';
			if stop>=start then
				o(string.sub(contex,start,stop));
			end
			start=i;
			stop=i;
			i=i+2;
			start=i;
		else
			stop=i;
			i=i+1
		end
	elseif status=="[%" then
		if string.sub(contex,i,i+1) =="%]" then
			w("\n");
			i=i+2;
			status="";
		else
			w(string.sub(contex,i,i));
			i=i+1;
		end
		start=i;
	elseif status=="[%=" then
		if string.sub(contex,i,i+1) =="%]" then
			w(");\n");
			i=i+2;
			status="";
		else
			w(string.sub(contex,i,i));
			i=i+1;
		end
		start=i;
	elseif status=="[%~" then
		if string.sub(contex,i,i+1) =="%]" then
			w(";\n");
			i=i+2;
			status="";
		else
			w(string.sub(contex,i,i));
			i=i+1;
		end
		start=i;
	end
	if si==i then
		print("error ",i);
		return 0;
	end
end
if stop>=start then
	o(string.sub(contex,start,stop));
end
target:write("return table.concat(lem_output);");
target:write("end");
print("end compile");
