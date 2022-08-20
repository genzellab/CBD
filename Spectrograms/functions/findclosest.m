function [Ind]=findclosest(a,b)
%a: Is a vector with all posible values
%b: Value which closest index you want to find
if size(a,2)> size(a,1)
    a=a.';
end

c=abs(a-b);
Ind=[];
for j=1:min(size(c))
    d=c(:,j);
    ind=find(d==min(d));
    Ind=[Ind ind];
end

% ind=find(c==min(c));


end