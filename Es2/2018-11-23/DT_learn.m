function T = DT_learn(X,Y,depth) % recursive function
    if (depth == 0 || ...
        length(unique(Y)) == 1) % Stop criteria for the recursive function
        T.isleaf = true;
        T.class = mode(Y);
    else
        T.isleaf = false;
        [n,d] = size(X);
        err_best = +Inf;
        for i1 = 1:d % d number of features
            [vX,i] = sort(X(:,i1), 'ascend'); % v value of my piints sorteed, i indexes of points -> tell were was the values in the orginal vector
            vY = Y(i);
            for i2 = i1:n-1
                % I have to check all my possible cuts
                if (vY(i2) ~= vY(i2+1))
                    err = mean([vY(1:i2) ~= mode(vY(1:i2));...
                                vY(i2+1:end)~=mode(vY(i2+1:end))]);
                    if (err_best > err)
                        err_best = err;
                        T.f = i1; % feature_best -> tree feature   
                        T.c = (vX(i2)+vX(i2+1))/2; % cut_best -> tree cut
                    end
                end
            end
        end
        f = X(:,T.f) <= T.c; % check all the points that are on the left of the best cut
        % T.left  = DT_learn(.., d-1)
        % T.rigth = DT_learn(.., d-1)
        T.left = DT_learn(X(f,:),Y(f),depth-1);
        T.right = DT_learn(X(~f,:),Y(~f),depth-1);
    end

end