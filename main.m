%Arquivo contento a base hist�rica
load('data.mat');

%Ser� selacionada a base 4 e a taxa de varian�a � de 90%
base_selection = 4; 
variance = 90;

%chama a fun��o TrainTest para alimentar as base treinamento e teste
[dataTrain,dataTeste] = TrainNtest_selection(base,base_selection);

%chama a fun��o T2NQNphi para calculo das varaiveis e aplica��o do PCA
[T2f,T2lim,Qf,Qlim,T2,Q, phi, philim] = t2NQNphi(dataTrain, dataTeste, variance);

%plotagem dos graficos das variaveis
plotfun(T2, Q, T2lim, Qlim, T2f, Qf, phi, philim);

%chama a fun��o fault_cont para verficiar qual � o momento da falha
[fault] = fault_cont(phi, philim, dataTeste);

%Gera o grafico de contribui��o
[contrigraph] = geraGraficoContribuicao(base,base_selection,dataTeste,philim,fault);