afdssf
[%~ local i = 1 %]
[%~ i=i+5 %]
[%=i%]
[% for i,v in pairs(T) do %]
[%=v%]
[% end %]
a]]
[% if T.stat==1 then %]
hello[%= T.stat %]1
[% else %]
other
[% end %]
adsfs
