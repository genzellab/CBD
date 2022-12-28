function [complexes] = find_overlap(ripple, sharpwave)
%FIND_OVERLAP 
%   We assume ripples always last longer than sharp waves, therefore we
%   will make a cell array for each ripple event, saving all sharpwaves
%   overlaping with each ripple, as seen so fat, complexes are always
%   composed by 1 ripple and one or more sharp waves
%   
%   - ripple must be an N by 2 array containing the start and end of ripple
%   events
%   - sharpwave must be an M by 2 array containing the start and end of
%   sharpwaves events
%   - complex is an 1 by N cell array, each cell contains a 0 <= Xi <= M 
%   number of indexes representing the sharpwave events that overlap on
%   each ripple

complexes = cell(1,length(ripple));
for i = 1:length(ripple)
    % Zero array for all rows
    overlaps = zeros(1,length(sharpwave));
    for j = 1:length(sharpwave) 
        % End of sharpwave is between start and end of ripple
        case1 = ripple(i, 1) <= sharpwave(j, 2) && ...
                ripple(i, 2) >= sharpwave(j, 2);
        % Start of sharpwave is between start and end of ripple
        case2 = ripple(i, 1) <= sharpwave(j, 1) && ...
                ripple(i, 2) >= sharpwave(j, 1);
        % When both cases are true, sharpwave is completely 
        % overlapped by a ripple
        if case1 || case2 
            % We mark overlaping event in row j at the overlaps 
            % array as nonzero when 
            overlaps(j) = 1;
        end
    end
    % We get row indexes of overlaping events and save them 
    % per ripple event
    complexes{i} = find(overlaps);
end

end

