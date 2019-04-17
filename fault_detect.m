function fault_statistics = fault_detect(modelo)

all_data = modelo.base_completa;
fault_statistics.base_completa = all_data;
[COEFF,~,~,~,~] = pca(all_data);
C = COEFF(:,1:modelo.num_componentes_escolhidas)*COEFF(:,1:modelo.num_componentes_escolhidas)';
X = C*all_data';
X = X'; 
fault_statistics.x= X;
warning off
[~,~,~,T2_tudo,~] = pca(X);
warning on
graficos = [];

t2f = T2_tudo(1);
ewma = 0.4;
ii = 0;
for i=1:length(T2_tudo)
t2f(i+1)=ewma*T2_tudo(i)+(1-ewma)*t2f(i);
    if t2f(i)>=modelo.UCL && ii==0
        ii = i;
    end
end
t2f = t2f';
fault_statistics.t2f = t2f;
for r = 1:size(t2f,1)
    graficos(r,:) = [t2f(r,:) , modelo.UCL];
end
figure
plot(graficos);
legend('T2','UCL');
hold off
end
