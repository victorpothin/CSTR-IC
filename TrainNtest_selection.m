    
%Fun��o para separar o que � dado de teste e o que � dado de treinamento
function [dataTrain,dataTeste] = TrainNtest_selection(datainput,base_selection)

    %Sele��o da base 4 dentro do arquivo de bases.
    dataTeste = normalize(cell2mat(datainput(4,base_selection)));
    
    %Base hist�rica para treinamento o algoritimo
    dataTrain = dataTeste(1:195,:);
    
end
