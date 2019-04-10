load datacstr.mat
%escolha dos dados com normalização
dadosbruto = normalize(cell2mat(base(4,1)));
variancias = 50;

%escolha de dados de operação normal
dados = dadosbruto(1:195,:);

%calculo de pca
[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED] = pca(dados);

%encontrar a quantidade de pca para o explained acumulado
sum_explained = 0;
componentes = 0;
while sum_explained < variancias
    componentes = componentes + 1;
    sum_explained = sum_explained + EXPLAINED(componentes);
end

%Coeficiente gerado pelas pca
C = COEFF(:,1:componentes)*COEFF(:,1:componentes)';
%transformação na matriz da pca com os dados originais
DadoFeitoPCA = C*dados';
DadoFeitoPCA = DadoFeitoPCA'; %organizando
% metodo para comparar as colunas de dado original com
% dados transformados com as pca.
coluna = 1;
comparar = [DadoFeitoPCA(:, coluna) , dados(:,coluna)];
plot(comparar,'DisplayName','comparar')
title('Comparação dos dados')
legend('Dados da pca','Dados originais')

%representação no sistema de PCA
Matriz_PCAdosDadosOriginais = COEFF(:,1:componentes)'*dados';
Matriz_PCAdosDadosOriginais = Matriz_PCAdosDadosOriginais';
