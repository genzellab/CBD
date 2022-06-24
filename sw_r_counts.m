% rat ids
rats = [2, 3, 4, 5, 9, 10, 11, 201, 203, 204, 205, 206, 207, 209, 210, 211, 212, 213, 214];
cbd_rats = {'Rat2', 'Rat5', 'Rat10', 'Rat11', 'Rat204', 'Rat205', 'Rat207', 'Rat209', 'Rat212', 'Rat214'};
veh_rats = {'Rat3', 'Rat4', 'Rat9', 'Rat201', 'Rat203', 'Rat206', 'Rat210', 'Rat211', 'Rat213'};

detections_dir = uigetdir('..', 'Folder with detection files');

detections_tables = struct();
for i = 1:length(rats)
    rat = [num2str(rats(i)) '.mat'];
    detections_file = fullfile(detections_dir, rat);
    detections_tables.(['rat' num2str(rats(i))]) = load(detections_file, 'grouped_oscil_table').grouped_oscil_table;
end

counts = struct();
fields = [cbd_rats, veh_rats];
categories = ["Total", "Ripples", "SharpWaves", "SharpWaveRipples", "ComplexSharpWaveRipples"];
animals = cellfun(@(c) str2double(c(4:end)), [cbd_rats, veh_rats], 'UniformOutput', false);
type_mask = [repelem("cbd", length(cbd_rats)), repelem("veh", length(veh_rats))];
for i = 1:length(categories)
    category = categories(i);
    counts.(category).('Rat') = animals';
    counts.(category).('Type') = type_mask';
    for j = 1:11
        bin = ['bin' num2str(j)];
        counts.(categories(i)).(bin) = [];
        for k = 1:length(fields)
            field = fields{k};
            rat = detections_tables.(field);
            total = rat.Peak > bin_size*(j-1) & rat.Peak < bin_size*j & rat.Sleep_State == 2;
            switch category
                case "Total"
                    count_mask = total;
                case "Ripples"
                    count_mask = total & cellfun(@(c) ismember(2,c) & length(c)==1, rat.Form);
                case "SharpWaves"
                    count_mask = total & cellfun(@(c) ismember(1,c) & length(c)==1, rat.Form);
                case "SharpWaveRipples"
                    count_mask = total & cellfun(@length,rat.Form) == 2;
                case "ComplexSharpWaveRipples"
                    count_mask = total & cellfun(@length,rat.Form) > 2;
            end
            result = height(rat(count_mask, :));
            if result == 0
                result = "";
            end
            counts.(categories(i)).(bin)(end + 1,1) = result;
        end
    end
end

results_dir = uigetdir('..', 'Folder to save resulting counts');
output_file = fullfile(results_dir, "counts_sw_r.xls");
sheets = fieldnames(counts);
for i = 1:length(sheets)
    sheet = sheets{i};
    count_table = struct2table(counts.(sheet));
    writetable(count_table, output_file,'Sheet',sheet+"Count");
end