function [dataTrain,dataTeste] = TrainNtest_selection(datainput,base_selection)
%Fun��o para separar o que � dado de teste e o que � dado de treinamento
dataTeste = cell2mat(datainput(4,base_selection));
dataTrain = dataTeste(1:195,:);
end

