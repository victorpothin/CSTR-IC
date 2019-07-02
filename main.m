%Arquivo contento a base histórica
load('data.mat');

%Será selacionada a base 4 e a taxa de variança é de 90%
base_selection = 4; 
variance = 90;

%chama a função TrainTest para alimentar as base treinamento e teste
[dataTrain,dataTeste] = TrainNtest_selection(base,base_selection);

%chama a função T2NQNphi para calculo das varaiveis e aplicação do PCA
[T2f,T2lim,Qf,Qlim,T2,Q, phi, philim] = t2NQNphi(dataTrain, dataTeste, variance);

%plotagem dos graficos das variaveis
plotfun(T2, Q, T2lim, Qlim, T2f, Qf, phi, philim);

%chama a função fault_cont para verficiar qual é o momento da falha
[fault] = fault_cont(phi, philim, dataTeste);

%Gera o grafico de contribuição
[contrigraph] = geraGraficoContribuicao(base,base_selection,dataTeste,philim,fault);