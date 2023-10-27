
load UORA.mat

figure(1)


subplot(4, 2, 1);
plot(NUM_STATIONS, THROUGHPUT_LIST)
title('Throughput')
xlabel('num station')
ylabel('Throughput (Mbps)')

subplot(4, 2, 2);
plot(NUM_STATIONS, PKT_COL_RATE_LIST)
title('PKT COL RATE')
xlabel('num station')
ylabel('PKT COL RATE (%)')

subplot(4, 2, 3);
plot(NUM_STATIONS, PKT_SUC_RATE_LIST)
title('PKT SUC RATE')
xlabel('num station')
ylabel('PKT SUC RATE (%)')

subplot(4, 2, 4);
plot(NUM_STATIONS, PKT_DELAY_LIST)
title('PKT Delay')
xlabel('num station')
ylabel('PKT Delay (us)')

subplot(4, 2, 5);
plot(NUM_STATIONS, RU_IDLE_RATE_LIST)
title('RU IDLE RATE')
xlabel('num station')
ylabel('RU IDLE RATE (%)')

subplot(4, 2, 6);
plot(NUM_STATIONS, RU_SUC_RATE_LIST)
title('RU SUC RATE')
xlabel('num station')
ylabel('RU SUC RATE (%)')

subplot(4, 2, 7);
plot(NUM_STATIONS, RU_COL_RATE_LIST)
title('RU COL RATE')
xlabel('num station')
ylabel('RU COL RATE (%)')

subplot(4, 2, 8);
plot(NUM_STATIONS, COM_STA_NUM_LIST)
title('COM STA NUM')
xlabel('num station')
ylabel('COM STA NUM')