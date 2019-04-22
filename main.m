load('data.mat');

base_selection = 2; %selecao da base
variance = 85;


[dataTrain,dataTeste] = TrainNtest_selection(base,base_selection);


[T2,T2lim,Q,Qlim] = t2NQ(dataTrain, dataTeste, variance);

