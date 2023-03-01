
%% Pelin Ozsezer

%%
clc
clear
addpath('/home/genzellab/Desktop/Pelin/functions');
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');

cd("/home/genzellab/Desktop/Pelin/slope-analysis-chronics-Adrian")
files=dir('GC_window*');

%% Remove empties %%
for file_no = 1:size(files,1)
    filename = files(file_no).name;
    rat_no=filename(57); SD=filename(68);
    load(filename); % GC_window_ripples_broadband_total
    filename = files(file_no).name;
    rat_no=filename(57); SD=filename(68);

    for pt=1:size(GC_window_ripples_broadband_total,2) % PTs
        if ~isempty(GC_window_ripples_broadband_total{1,pt})
            C=GC_window_ripples_broadband_total{1,pt};
            C=C(~all(cellfun(@isempty,C),2),:);
            GC_window_ripples_broadband_total{1,pt}=C;
        end
    end
    temp_var = strcat( "save GC_rat",num2str(rat_no),"_SD",num2str(SD),...
        ".mat GC_window_ripples_broadband_total");
    eval(sprintf('%s',temp_var));
end


%% Compute slopes and offsets %%
clear variables
files=dir('GC_rat*');

for file_no = 1:size(files,1)
    filename = files(file_no).name;
    rat_no=filename(7); SD=filename(11);
    [ 'Rat ',num2str(rat_no),' - SD',num2str(SD)]
    load(filename); % GC_window_ripples_broadband_total
    for pt=7:size(GC_window_ripples_broadband_total,2) % PTs
        [ 'Rat ',num2str(rat_no),' - SD',num2str(SD),' - pt',num2str(pt),'/9']
        if ~isempty(GC_window_ripples_broadband_total{1,pt})
            C=GC_window_ripples_broadband_total{1,pt}(:,1);
            compute_spectra(C);

            % call FOOOF from Python
            system('python slope-analysis.py');

            % csv to mat
            slope_pfc=readmatrix("slopes_pfc.csv");
            slope_pfc=-1*slope_pfc(2:end,2);
            slope_hpc=readmatrix("slopes_hpc.csv");
            slope_hpc=-1*slope_hpc(2:end,2);

            offset_pfc=readmatrix("offsets_pfc.csv");
            offset_pfc=offset_pfc(2:end,2);
            offset_hpc=readmatrix("offsets_hpc.csv");
            offset_hpc=offset_hpc(2:end,2);

            %% CHECK if sizes match
            load('power_spec_pfc.mat')
            if ~length(slope_pfc)== size(power_spec_pfc,1)
                msg = 'Error: Dimensions do not match!';
                error(msg)
            end

            %
            for i=1:size(slope_hpc,1)
                slopes{i,1} =[slope_pfc(i,1);slope_hpc(i,1)];
                offsets{i,1} =[offset_pfc(i,1);offset_hpc(i,1)];
            end

            GC_window_ripples_broadband_total{1,pt}(:,8)=slopes;
            GC_window_ripples_broadband_total{1,pt}(:,9)=offsets;
        end
        data_info=['In Cells: 1st row-PFC; 2nd row-HPC. Columns: 2-start; 3-peak; 4-end; 5-duration; 6-SO phase; 7-; 8-slope; 9-offset.'];

        temp_var = strcat( "save GC_rat",num2str(rat_no),"_SD",num2str(SD),...
            ".mat GC_window_ripples_broadband_total data_info");
        eval(sprintf('%s',temp_var));
        delete freq.mat
        delete freq.csv
        delete slopes_hpc.csv
        delete slopes_pfc.csv
        delete offsets_hpc.csv
        delete offsets_pfc.csv
        delete power_spec_hpc.csv
        delete power_spec_hpc.mat
        delete power_spec_pfc.csv
        delete power_spec_pfc.mat
        clear power_spec_pfc slope_hpc slope_pfc slopes offsets
    end
end
