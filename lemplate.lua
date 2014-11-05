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
	if #str<80 then
		str=string.gsub(str,"\\",'\\\\');
		str=string.gsub(str,"\n",'\\n');
		str=string.gsub(str,"\r",'\\r');
		str=string.gsub(str,"\t",'\\t');
		str=string.gsub(str,"\a",'\\a');
		str=string.gsub(str,"\b",'\\b');
		str=string.gsub(str,"\f",'\\f');
		str=string.gsub(str,"\v",'\\v');
		str=string.gsub(str,'"',[[\"]]);
		return '"','"',str;
	end
	local l="[[";
	local r="]]";
	local level=1;
	while true do
		local fl=string.gsub(l,"%[","%%[");
		local fr=string.gsub(r,"%]","%%]");
		if string.find(str,fl) or string.find(str,fr) then
			local m="";
			for i=1,level do
				m=m.."=";
			end
			l="["..m.."[";
			r="]"..m.."]";
		else
			break;
		end
		level=level+1;
	end
	return l,r,str;
end
local o=function(str) 
	if string.sub(str,1,1)=="\n" then 
		str="\n"..str;
	end
	local l,r,str=quote(str);
	w("o("..l..str..r..");\n"); 
end
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
