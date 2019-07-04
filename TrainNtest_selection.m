    
%Função para separar o que é dado de teste e o que é dado de treinamento
function [dataTrain,dataTeste] = TrainNtest_selection(datainput,base_selection)

    %Seleção da base 4 dentro do arquivo de bases.
    dataTeste = normalize(cell2mat(datainput(4,base_selection)));
    
    %Base histórica para treinamento o algoritimo
    dataTrain = dataTeste(1:195,:);
    
end
