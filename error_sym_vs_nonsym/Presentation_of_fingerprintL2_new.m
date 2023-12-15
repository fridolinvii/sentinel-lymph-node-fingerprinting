clear all; close all;

T = ([1 2 4 8 16]);
lT = log([1 2 4 8 16]);

R3{1} = [ 2.4495 1.7321 1.4142 1.4142 1.4142];
R3{7} = [5.2348 2.7687 2.2071 2.7687 2.2071];
R3{8} = [9.6033  3.5262 2.8458 1.9428 3.1596];




% 60 Mbq at 1 second corresponds to 30 Mbq at 2 second, hence 1s has to be
% at 2 s
N{1} = [6.4031 6.4031 6.4031 6.4031 6.4031];
N{7} = [5.4376 6.5372 5.4376  5.4376  6.5372];
N{8} = [12.2635 15.2517 16.0665 9.2885  9.2885];


nN{1} = [1.4142 1.4142 1.4142 1.4142 1.4142];
nN{7} = [7.6844  4.3198  4.3198  2.8059  2.8059];
nN{8} = [12.2635 15.2517 16.0665 9.2885  9.2885];



figure(1)
lw = 4;
plot(T,N{1},'b-o',T,N{7},'b--o','LineWidth',lw)
hold on
plot(T,R3{1},'r-*',T,R3{7},'r--*','LineWidth',lw);
hold off
legend('1 Source - with Walls','2 Source - with Walls','1 Source - no Walls','2 Source - no Walls')
xlabel('time [s]'); ylabel('mean L^2-error [mm]')
set(gca, 'XTick',T, 'FontSize',32)
