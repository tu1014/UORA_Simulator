

set_Parameter;

PKT_COL_RATE_LIST = zeros(1, size(NUM_STATIONS, 2));
PKT_SUC_RATE_LIST = zeros(1, size(NUM_STATIONS, 2));
PKT_DELAY_LIST = zeros(1, size(NUM_STATIONS, 2));

THROUGHPUT_LIST = zeros(1, size(NUM_STATIONS, 2));

RU_IDLE_RATE_LIST = zeros(1, size(NUM_STATIONS, 2));
RU_COL_RATE_LIST = zeros(1, size(NUM_STATIONS, 2));
RU_SUC_RATE_LIST = zeros(1, size(NUM_STATIONS, 2));
COM_STA_NUM_LIST = zeros(1, size(NUM_STATIONS, 2));

fprintf("====Simulation Start====\n")

list_index = 1;

for num_station = NUM_STATIONS

    % Packet Performance
    PKT_TX = 0;
    PKT_SUCCESS = 0;
    PKT_COLLISION = 0;
    PKT_DELAY = 0;
    
    % RU Performance
    RU_IDLE = 0;
    RU_SUCCESS = 0;
    RU_COLLISION = 0;
    COMPETITION_STATION = zeros(1, NUM_DTI);

    % Simulation
    for num_sim = 1:NUM_SIM
        
        % create station list
        for index = 1:num_station
            station_list(index) = Station(OCW_MIN, OCW_MAX);
        end

        % Simulation
        for num_dti = 1:NUM_DTI
            
            % Allocate RU
            for index = 1:num_station
                station_list(index).pkt_delay = station_list(index).pkt_delay + 1;

                if station_list(index).obo < NUM_RU
                    station_list(index).tx_status = true;
                    station_list(index).ru = randi(NUM_RU);
                else
                    station_list(index).tx_status = false;
                    station_list(index).obo = station_list(index).obo - NUM_RU;
                end
            end
            
            % Create Collision Map
            collision_map = zeros(1, NUM_RU);
            for index = 1:num_station
                if station_list(index).tx_status
                    collision_map(1, station_list(index).ru) = collision_map(1, station_list(index).ru) + 1;
                end
            end

            % Check Collision
            for index = 1:num_station
                if station_list(index).tx_status
                    if collision_map(1, station_list(index).ru) == 1
                        station_list(index).tx_result = true; % success
                    else
                        station_list(index).tx_result = false; % collision
                    end
                end
            end

            % Update PKT Performance Stats
            for index = 1:num_station
                if station_list(index).tx_status
                    PKT_TX = PKT_TX + 1;
                    if station_list(index).tx_result
                        PKT_SUCCESS = PKT_SUCCESS + 1;
                        PKT_DELAY = PKT_DELAY + station_list(index).pkt_delay;
                    else
                        PKT_COLLISION = PKT_COLLISION + 1;
                    end
                end
            end

            % Update RU Performance Stats
            col_sta_num = 0;
            for ru = 1:NUM_RU
                col_sta_num = col_sta_num + collision_map(1, ru);
                if collision_map(1, ru) == 0
                    RU_IDLE = RU_IDLE + 1;

                elseif collision_map(1, ru) == 1
                    RU_SUCCESS = RU_SUCCESS + 1;

                else
                    RU_COLLISION = RU_COLLISION + 1;
                end
            end
            COMPETITION_STATION(num_dti) = col_sta_num;

            % Update Station Variables
            for index = 1:num_station
                if station_list(index).tx_status
                    if station_list(index).tx_result
                        station_list(index).ru = -1;
                        station_list(index).ocw = OCW_MIN;
                        station_list(index).pkt_delay = 0;
                    else
                        station_list(index).ru = -1;
                        station_list(index).ocw = station_list(index).ocw * 2;
                        if station_list(index).ocw > OCW_MAX
                            station_list(index).ocw = OCW_MAX;
                        end
                    end
                    station_list(index).obo = randi(station_list(index).ocw)-1;
                    station_list(index).tx_status = false;
                    station_list(index).tx_result = false;
                end
            end

        end

    end

    % Add Performance Stat to List
    PKT_COL_RATE_LIST(list_index) = (PKT_COLLISION / PKT_TX) * 100;
    PKT_SUC_RATE_LIST(list_index) = (PKT_SUCCESS / PKT_TX) * 100;
    PKT_DELAY_LIST(list_index) = (PKT_DELAY / PKT_SUCCESS) * TWT_INTERVAL; %us
    
    THROUGHPUT_LIST(list_index) = (PKT_SIZE * 8 * PKT_SUCCESS) / (NUM_SIM * NUM_DTI * TWT_INTERVAL); % us

    RU_TOTAL = RU_IDLE + RU_COLLISION + RU_SUCCESS;
    RU_SUC_RATE_LIST(list_index) = (RU_SUCCESS / RU_TOTAL) * 100;
    RU_COL_RATE_LIST(list_index) = (RU_COLLISION / RU_TOTAL) * 100;
    RU_IDLE_RATE_LIST(list_index) = (RU_IDLE / RU_TOTAL) * 100;
    COM_STA_NUM_LIST(list_index) = mean(COMPETITION_STATION);

    fprintf("STA NUM : %d\n", num_station)

    list_index = list_index + 1;

end

clear BA_SIZE BA_TIME col_sta_num collision_map COMPETITION_STATION DATA_RATE DIFS DTI
clear index list_index num_dti NUM_DTI NUM_RU num_sim NUM_SIM num_station OCW_MAX OCW_MIN
clear ru SIFS SLOT_TIME station_list TF_TIME TF_SIZE TWT_INTERVAL

save PerformanceStats.mat;

fprintf("====Simulation Finish====\n")