function Y = DT_learn(T,X)
% X -> points to classify

% I have to classify all the points

n = size(X,1);
Y = zeros(n,1);
for i = 1:n
    Ttmp = T;
    while(true)
        if (Ttmp.isleaf)
            Y(i) = Ttmp.class;
            break;
        else
            if (X(i,Ttmp.f) <= Ttmp.c)
                
                Ttmp = Ttmp.left;
            else
                Ttmp = Ttmp.right;
            end
        end
    end
end

end

