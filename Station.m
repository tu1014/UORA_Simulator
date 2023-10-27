
classdef Station
    %STATION 이 클래스의 요약 설명 위치
    %   자세한 설명 위치
    
    properties
        ru;
        ocw;
        obo;
        tx_status;
        tx_result;
        ocw_min;
        ocw_max;
        pkt_delay;
    end
    
    methods
        function station = Station(OCW_Min, OCW_Max)
            station.ocw_min = OCW_Min;
            station.ocw_max = OCW_Max;
            station.ocw = OCW_Min;
            station.obo = randi(station.ocw)-1;
            station.tx_status = false;
            station.tx_result = false;
            station.ru = -1;
            station.pkt_delay = 0;
        end
    end

end

