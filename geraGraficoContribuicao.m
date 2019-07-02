%Geração do gráfico de contrinuição
function [contrigraph] = geraGraficoContribuicao(base,base_selection,dataTeste,philim,fault)

    %criação da matriz logica
    matrizlogica = [];

    for i= 1:14
       for j= 1:14
           if i == j
                matrizlogica(i,j) = 1;     
           end       
       end       
    end

    faultBin = cell2mat(base(3, base_selection ));

    faultBin = faultBin';

    M = philim^(1/2);

    dataContri = dataTeste(fault-15:fault+15, : );

    contrigraph = [];

    for j = 1:14
        for i = 1:30
            contrigraph(j,i) = (dataContri(i , :)*(matrizlogica(:, j))*M)^2;
        end
    end

end

