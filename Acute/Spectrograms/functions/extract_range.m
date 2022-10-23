function [output]=extract_range(array,center,x,y)

array=array(:,center+x:center+y);
output=array;

end