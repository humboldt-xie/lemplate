return function(T,fun) 
	local lem_output={};
	local o=function(str)
		table.insert(lem_output,str);
	end
	if fun~=nil then 
		o=fun;
	end
o([=[afdssf
]=]);
 local i = 1 ;
o([=[
]=]);
 i=i+5 ;
o([=[
]=]);
o(i);
o([=[
]=]);
 for i,v in pairs(T) do 
o([=[
]=]);
o(v);
o([=[
]=]);
 end 
o([=[
a]]
]=]);
 if T.stat==1 then 
o([=[
hello]=]);
o( T.stat );
o([=[1
]=]);
 else 
o([=[
other
]=]);
 end 
o([=[
adsfs
]=]);
return table.concat(lem_output);end