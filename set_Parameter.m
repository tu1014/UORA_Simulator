
% SIM Options
NUM_SIM = 1;
NUM_DTI = 50000;

NUM_STATIONS = [1 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100];

% WLAN Pamrameter
DATA_RATE = 1; % Gbps
NUM_RU = 8;
OCW_MIN = 8;
OCW_MAX = 64;

% SIZE
PKT_SIZE = 1000; % byte
TF_SIZE = 89; % byte
BA_SIZE = 32; % byte

% TIME
SLOT_TIME = 9; % us
SIFS = 16; % us
DIFS = 18; % us
DTI = 32; % us
TF_TIME = (TF_SIZE * 8) / (DATA_RATE * 1000); % us
BA_TIME = (BA_SIZE * 8) / (DATA_RATE * 1000); % us
TWT_INTERVAL = DIFS + TF_TIME + SIFS + DTI + SIFS + BA_TIME;








