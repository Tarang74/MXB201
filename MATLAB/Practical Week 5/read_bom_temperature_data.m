function [day, Tmax, station_info] = read_bom_temperature_data(url)

% Download and unzip the BOM temperature data
filenames = unzip(url);

% Read data into a table
warnstate = warning;
warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');
tab = readtable(filenames{1});
warning(warnstate);

% Identify days with missing temperature data
missing = isnan(tab.MaximumTemperature_DegreeC_);

% Strip out the missing days
tab = tab(~missing, :);

% Convert the year, month, day fields into a MATLAB datetime object
tab.day = datetime(tab.Year, tab.Month, tab.Day);

% Calculate the number of days prior the most recent measurement
day = days(tab.day - tab.day(end));

% Pull out the maximum temperatures
Tmax = tab.MaximumTemperature_DegreeC_;

% Range of data
station_info.range = tab.day([1,end]).';

if tab.Year(end) ~= 2022
    error('The site selected does not have data up to the year 2022.')
end

if length(tab.Year) < 30 * 365.25
    error('The site selected does not have at least 30 years of valid data.')
end

% Open the station info file
fid = fopen(filenames{2});

% Extract the station name
for i = 1:11
    line = fgetl(fid);
end
station_info.name = line(15:end);

% Extract the station location
for i = 1:3
    line = fgetl(fid);
end
station_info.latitude = str2double(line(45:end));
line = fgetl(fid);
station_info.longitude = str2double(line(45:end));

% Close the station info file
fclose(fid);