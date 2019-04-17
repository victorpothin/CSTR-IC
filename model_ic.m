function model = model_ic(x,variance,base_escolhida)

model.variance = variance;
model.base_escolhida = base_escolhida;
model.base_completa = cell2mat(x(4,base_escolhida));
dadosbruto = normalize(cell2mat(x(4,base_escolhida)));
dados = dadosbruto(1:195,:);
[rows,colun] = size(dados);
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
model.c = C;
DadoFeitoPCA = C*dados';
DadoFeitoPCA = DadoFeitoPCA'; 
model.modelo_dos_dadoscomPCA = DadoFeitoPCA; 
warning off
[~,~,~,T2_semfalha,~] = pca(DadoFeitoPCA);
model.T2_modelo = T2_semfalha;
warning on

%UCL - limite superior da estatistica
an = componentes;
nn = length(T2_semfalha);
F = finv(0.95, componentes,(size(T2_semfalha,1)-componentes));
model.UCL = ((an*(nn-1)*(nn+1))/(nn*(nn-an)))*F;

%SPE
ewma = 0.4;
Q=zeros(1,length(DadoFeitoPCA));
Q = Q';
Qf=zeros(1,length(DadoFeitoPCA));
Qf = Qf';
for j = 2:length(DadoFeitoPCA)   
r=DadoFeitoPCA(j,:)*(eye(colun)-C*C')*DadoFeitoPCA(j,:)';
Q(j)=r*r';
Qf(j)=ewma*Q(j)+(1-ewma)*Qf(j-1);
end
model.Q = Qf;
end
