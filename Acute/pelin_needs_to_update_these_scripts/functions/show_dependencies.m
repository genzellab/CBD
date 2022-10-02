% List required files and toolboxes.
function show_dependencies(mfilename)
    if ~isdeployed
        fullFileName = [mfilename, '.m'];
        [requiredFileList, toolboxList] = matlab.codetools.requiredFilesAndProducts(fullFileName);
        fprintf('Required m-files:\n');
        for k = 1 : length(requiredFileList)
            fprintf('    %s\n', requiredFileList{k});
        end
        fprintf('Required MATLAB Toolboxes:\n');
        for k = 1 : length(toolboxList)
            fprintf('    %s\n', toolboxList(k).Name);
        end
    end
end