function model = model_ic(x,variance,base_escolhida)

model.variance = variance;
model.base_escolhida = base_escolhida;
model.base_completa = cell2mat(x(4,base_escolhida));
dadosbruto = normalize(cell2mat(x(4,base_escolhida)));
dados = dadosbruto(1:195,:);
[rows,col] = size(dados);
model.tamanho_da_amostra = rows;
[COEFF,~,~,~,EXPLAINED] = pca(dados);
model.porcentagem_todasPCAs = EXPLAINED;

sum_explained = 0;
componentes = 0;
while sum_explained < variance
    componentes = componentes + 1;
    sum_explained = sum_explained + EXPLAINED(componentes);
end
model.sum_variancia_pelas_PCAs = sum_explained;
model.num_componentes_escolhidas = componentes;

C = COEFF(:,1:componentes)*COEFF(:,1:componentes)';
DadoFeitoPCA = C*dados';
DadoFeitoPCA = DadoFeitoPCA'; 
model.modelo_dos_dadoscomPCA = DadoFeitoPCA; 
[~,~,~,T2_semfalha,~] = pca(DadoFeitoPCA);
model.T2_modelo = T2_semfalha;




end

