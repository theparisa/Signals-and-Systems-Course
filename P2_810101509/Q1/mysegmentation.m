function [L, Ne] = mysegmentation(picc)
    flag = 1;
    L = zeros(300, 500);
    for i = 1:500
        for j = 1:300
            if picc(j, i) == 1 && L(j, i) == 0
                S = [j, i];
                L(j, i) = flag;
                while ~isempty(S)
                    current_pixel = S(1, :);
                    S(1, :) = [];
                    for k = -1:1
                        for l = -1:1
                            new_x = current_pixel(1) + k;
                            new_y = current_pixel(2) + l;
                            if new_x >= 1 && new_x <= 300 && new_y >= 1 && new_y <= 500 && picc(new_x, new_y) == 1 && L(new_x, new_y) == 0
                                S = [S; new_x, new_y];
                                L(new_x, new_y) = flag;
                            end
                        end
                    end
                end
                Ne = flag;
                flag = flag + 1;
            end
        end
    end
end
