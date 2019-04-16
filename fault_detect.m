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
fault_statistics.T2_all = T2_tudo;
warning on
graficos = [];
for i2 = 1:size(T2_tudo,1)
    graficos(i2,:) = [T2_tudo(i2,:) , modelo.UCL];
end
figure
plot(graficos);
legend('T2','UCL');
hold off
end
