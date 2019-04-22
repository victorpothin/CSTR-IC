function [dataTrain,dataTeste] = TrainNtest_selection(datainput,base_selection)
%Função para separar o que é dado de teste e o que é dado de treinamento
dataTeste = cell2mat(datainput(4,base_selection));
dataTrain = dataTeste(1:195,:);
end

