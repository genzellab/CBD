%% Pelin Ozsezer

%% Move the files of the channels in 'HPC_32channels' to the required folder structure
%% Required: Each channel as 1,2,... -> Each rat's corresponding channel as 1,2,...

clc
clear
format compact

%% Check if there is directory called 'brain_regions', if not, create
% cd /home/genzellab/Desktop/Pelin
% mkdir brain_regions
cd /home/genzellab/Desktop/Pelin/brain_regions

%% create folders for HPC channels
for i=1:32
    temp_var = strcat( "mkdir ",num2str(i));
    eval(sprintf('%s',temp_var));
end

%% Original channel - mapping pair
% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214
rats_1to32 = [2 3 5] ; 
rats_33to64 = [9 10 11 201 203 204 205 206 207 209 210 211 212 213 214]; 

chan_1to32=[ 5 28 10 23 7 26 2 31 12 21 8 25 1 32 9 24 13 20 6 27 11 22 16 17 4 29 14 19 15 18 3 30 ] ; 
chan_33to64=[ 37 60 42 55 39 58 34 63 44 53 40 57 33 64 41 56 45 52 38 59 43 54 48 49 36 61 46 51 47 50 35 62 ] ;

%% move every rat's channels to the specific channel folders and RENAME
% channel 1:32
cd /home/genzellab/Desktop/Pelin/HPC_32channels
for rat=rats_1to32 

    % channel by channel
    for ch=1:32
        x=chan_1to32(ch);
        temp_var = strcat( 'cd /home/genzellab/Desktop/Pelin/HPC_32channels/ratID',num2str(rat));
        eval(sprintf('%s',temp_var));

        % move
        temp_var = strcat( "movefile ratID",num2str(rat),"_HPC_CH",num2str(x),...
            ".continuous.mat /home/genzellab/Desktop/Pelin/brain_regions/",num2str(ch));
        eval(sprintf('%s',temp_var));

        % rename
        temp_var = strcat( "cd /home/genzellab/Desktop/Pelin/brain_regions/",num2str(ch));
        eval(sprintf('%s',temp_var));

        temp_var = strcat( "movefile ratID",num2str(rat),"_HPC_CH",num2str(x),...
            ".continuous.mat ",num2str(rat),".mat");
        eval(sprintf('%s',temp_var));

    end
end

% channel 33:64
cd /home/genzellab/Desktop/Pelin/HPC_32channels
for rat=rats_33to64

    % channel by channel
    for ch=1:32
        x=chan_33to64(ch);
        temp_var = strcat( 'cd /home/genzellab/Desktop/Pelin/HPC_32channels/ratID',num2str(rat));
        eval(sprintf('%s',temp_var));

        % move
        temp_var = strcat( "movefile ratID",num2str(rat),"_HPC_CH",num2str(x),...
            ".continuous.mat /home/genzellab/Desktop/Pelin/brain_regions/",num2str(ch));
        eval(sprintf('%s',temp_var));

        % rename
        temp_var = strcat( "cd /home/genzellab/Desktop/Pelin/brain_regions/",num2str(ch));
        eval(sprintf('%s',temp_var));

        temp_var = strcat( "movefile ratID",num2str(rat),"_HPC_CH",num2str(x),...
            ".continuous.mat ",num2str(rat),".mat");
        eval(sprintf('%s',temp_var));

    end
end


%%
cd /home/genzellab/Desktop/Pelin/brain_regions

for i=1:32
    temp_var = strcat( "movefile ",num2str(i)," HPC",num2str(i));
    eval(sprintf('%s',temp_var));
end









