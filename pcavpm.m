load data.mat
%escolha dos dados com normalização
dadosbruto = normalize(cell2mat(base(4,5)));
variancias = 80;

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
P = diag(COEFF(:,1:componentes));
P = diag(P);
%transformação na matriz da pca com os dados originais
DadoFeitoPCA = C*dados';
DadoFeitoPCA = DadoFeitoPCA'; %organizando
% metodo para comparar as colunas de dado original com
% dados transformados com as pca.
        % coluna = 1;
        % comparar = [DadoFeitoPCA(:, coluna) , dados(:,coluna)];
        % plot(comparar,'DisplayName','comparar')
        % title('Comparação dos dados')
        % legend('Dados da pca','Dados originais')

%representação no sistema de PCA
MPCA = COEFF(:,1:componentes)'*dados';
MPCA = MPCA';

%Estatistica Hotelling T2 na matriz PCA dos dados.

%Media amostral mi
mi = median(MPCA);

%Matriz covariança S
%S = MPCA*MPCA'/size(MPCA,1)-1;
S = (MPCA-mi)'*(MPCA-mi)/size(MPCA,1)-1;
A = diag(eigs(S,componentes));
MINVS = inv(S);
%T2
T2 = [];
T2 = [];
for i = 1:size(MPCA,1)
    aux = P*MPCA(i,:)';
    T2(i,:) = (MPCA(i,:)*P')*(MINVS)*aux;        
end
%http://www2.ic.uff.br/~aconci/PCA-ACP.pdf
%http://repositorio.ufes.br/bitstream/10/9643/1/tese_6869_Dissertacao_GercilioZuqui_Revisao_Final.pdf#%5B%7B%22num%22%3A93%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C54%2C290%2C0%5D
