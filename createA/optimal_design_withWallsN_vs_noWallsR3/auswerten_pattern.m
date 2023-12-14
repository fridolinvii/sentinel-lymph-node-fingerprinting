clear all; close all
load error


hold on 
plot(error{1},'-ob')
plot(error{2},'-or')
plot(error{3},'-or')

legend('1 Source Symetric V-Value','2 Source Symetric V-Value','3 Source Symetric V-Value','1 Source non-Symetric V-Value','2 Source non-Symetric V-Value','3 Source non-Symetric V-Value')


mean(error{1})
mean(error{2})
mean(error{3})

