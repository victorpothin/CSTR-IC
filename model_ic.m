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
r=dados(j,:)*(eye(colun)-C)*dados(j,:)';
Q(j)=r*r';
Qf(j)=ewma*Q(j)+(1-ewma)*Qf(j-1);
end
model.Q_modelo = Qf;
%limitQ mas tem que dar uma conferida no calculo
alfa = 0.99;
Cv = cov(dados);
[~,sv,~] = svd(Cv);
ds = diag(sv);
teta1 = sum(ds(an+1:end));
teta2 = sum(ds(an+1:end).^2);
teta3 = sum(ds(an+1:end).^3);
h0 = 1 - (2*teta1*teta3)/(3*teta2^2);
Ca=norminv([0 alfa],0,1);
Ca=Ca(2);
Qlim = teta1*((h0*Ca*sqrt(2*teta2)/teta1) + 1 + (teta2*h0*(h0-1))/(teta1^2))^(1/h0);
model.Qlim = Qlim;

end
% 
% x = base;
% variance = 85;
% base_escolhida = 1;
% 
% 
% model.variance = variance;
% model.base_escolhida = base_escolhida;
% model.base_completa = cell2mat(x(4,base_escolhida));
% dadosbruto = normalize(cell2mat(x(4,base_escolhida)));
% dados = dadosbruto(1:195,:);
% [rows,colun] = size(dados);
% model.tamanho_da_amostra = rows;
% 
% 
% C = cov(dados);
% [u, s, v] = svd(C);
% 
% ds = diag(s);
% ds = ds/sum(ds);
% 
% a = 0;
% for i=1:length(ds)
%     Acumm(i) = sum(ds(1:i));
%     if Acumm(i)>=(variance/100) && a==0 
%     a = i;
%     end
% end
% 
% clear ds
% 
% T = u(:,1:a);
% P = dados*T;
% Precons = T*P';
% 
% n = length(rows);
% alfa = 0.99;
% t2lim= (a*(n-1)*(n+1)/(n*(n-a)))*finv(alfa,a,n-a);
% 
% % Calculo do limiar da estatistica Q
% ds = diag(s);
% teta1 = sum(ds(a+1:end));
% teta2 = sum(ds(a+1:end).^2);
% teta3 = sum(ds(a+1:end).^3);
% 
% h0 = 1 - (2*teta1*teta3)/(3*teta2^2);
% Ca=norminv([0 alfa],0,1);
% Ca=Ca(2);
% Qlim = teta1*((h0*Ca*sqrt(2*teta2)/teta1) + 1 + (teta2*h0*(h0-1))/(teta1^2))^(1/h0);
% 
% 
% M = dados;
% 
% s2 = s(1:a, 1:a);
% for i=1:length(M)
% t2(i)=M(i,:)*(T*(s2^-1)*T')*M(i,:)';
% end
% 
% t2f = t2(1);
% ewma = 0.4;
% ii = 0;
% for i=1:length(t2)
% t2f(i+1)=ewma*t2(i)+(1-ewma)*t2f(i);
%     if t2f(i)>=t2lim && ii==0
%         ii = i;
%     end
% end
% 
% for i=1:length(M)
% Error = M(i,:)' - T*(M(i,:)*T)'; 
% Q(i) = Error'*Error;
% CONT_FalhaQ(i,:) = Error.^2;
% end
% 
% Qf = Q(1);
% ewma = 0.3;
% for i=1:length(Q)
% Qf(i+1)=ewma*Q(i)+(1-ewma)*Qf(i);
% end
% Qf = Qf(2:end);
