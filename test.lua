return function(T,fun) 
	local lem_output={};
	local o=function(str)
		table.insert(lem_output,str);
	end
	if fun~=nil then 
		o=fun;
	end
o("\\afdssf\n");
 local i = 1 ;
o("\n\n");
 i=i+5 ;
o("\n\n");
o(i);
o("\n\n");
 for i,v in pairs(T) do 
o("\n\n");
o(v);
o("\n\n");
 end 
o("\n\na]]\n");
 if T.stat==1 then 
o("\n\nhello");
o( T.stat );
o("1\n");
 else 
o("\n\nother\n");
 end 
o("\n\nadsfs\n[[ ]]\n");
o(5 );
o([=[

aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
[[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa]]


]=]);
return table.concat(lem_output);end