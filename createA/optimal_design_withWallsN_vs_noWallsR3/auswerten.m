clear all; close all
load error100


hold on 
plot(error1{1},'-ob')
plot(error2{1},'--ob')
plot(error3{1},'-.ob')
plot(error1{2},'-or')
plot(error2{2},'--or')
plot(error3{2},'-.or')

legend('1 Source Symetric V-Value','2 Source Symetric V-Value','3 Source Symetric V-Value','1 Source non-Symetric V-Value','2 Source non-Symetric V-Value','3 Source non-Symetric V-Value')

"Symmetric septum V-Value"
mean(error1{1})
mean(error2{1})
mean(error3{1})
mean(error4{1})

"Symmetric V-Value"
mean(error1{3})
mean(error2{3})
mean(error3{3})
mean(error4{3})

"non-Symmetric V-Value"
mean(error1{2})
mean(error2{2})
mean(error3{2})
mean(error4{2})




[mean(error1{1}),mean(error1{3}),mean(error1{2})]