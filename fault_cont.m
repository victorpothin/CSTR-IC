function [fault] = fault_cont(phi, philim, base_complete)
    fault = [];
    for i = 1:size(base_complete,1)
        if phi(i) >  philim
             fault = i;
             break
        end
    end
    return 
end
