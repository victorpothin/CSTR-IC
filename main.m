load('data.mat');

%horas = [];
%for ini = 1:170

    
base_selection = 25; %selecao da base
variance = 90;


[dataTrain,dataTeste] = TrainNtest_selection(base,base_selection);


[T2f,T2lim,Qf,Qlim,T2,Q, phi, philim] = t2NQNphi(dataTrain, dataTeste, variance);

plotfun(T2, Q, T2lim, Qlim, T2f, Qf, phi, philim);





% 
% for i = 1:size(T2,2)
%     ii = i+1;
%     iii = i+2;
%     i = i+3;
%     aux1 = (T2f(i)+T2f(ii)+T2f(iii))/3;
%     aux2 = (Qf(i)+Qf(ii)+Qf(iii))/3;
%     if(aux1 >= T2lim  && aux2 >= Qlim)
%         hora_com_filtro = i-3;
%         break
%     end
%     if (i >= size(T2,2)-1)
%             break
%     end
% end
%clear i;
% for i = 1:size(T2,2)
%     ii = i+1;
%     iii = i+2;
%     i = i+3;
%     aux1 = (T2(i)+T2(ii)+T2(iii))/3;
%     aux2 = (Q(i)+Q(ii)+Q(iii))/3;
%     if(aux1 >= T2lim  && aux2 >= Qlim)
%         hora_sem_filtro = i-3;
%         break
%     end
%     if (i >= size(T2,2)-1)
%             break
%     end
% end

%horas(ini,:) = [ hora_com_filtro,hora_sem_filtro ];
% end





