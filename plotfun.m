function plotfun(t2, q, t2lim, qlim, t2f, qf)


grafico = [];
 for i = 1:size(t2,2) 
     grafico(i,:)= [t2(i), q(i), qlim , t2lim, t2f(i), qf(i) ];
 end

figure(1)%Figure T2
    plot(grafico(:,[1,4]),'DisplayName','grafico(:,[1,4])')
    xlabel('Time (h)');
    legend('T2 sem filtro','threshold T2')
figure(2)%Figure Q
    plot(grafico(:,2:3),'DisplayName','grafico(:,2:3)')
    xlabel('Time (h)');
    legend('Q sem filtro','threshold Q')
figure(3)%figure T2 com filtro
    plot(grafico(:,4:5),'DisplayName','grafico(:,4:5)')
    xlabel('Time (h)');
    legend('threshold T2','T2 com filtro')
figure(4)%figure Q com filtro
    plot(grafico(:,[3,end]),'DisplayName','grafico(:,[3,end])')
    xlabel('Time (h)');
    legend('threshold Q','Q com filtro')
end

