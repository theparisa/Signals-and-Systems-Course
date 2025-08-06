close all;
clc;clear;
% Reading Images
PCB=imread('PCB.jpg');
IC=imread('IC.png');
PCB=rgb2gray(PCB);
IC=rgb2gray(IC);
 
figure
imshow(PCB)
hold on


function findMatches(pcb, ic, edgeColor)
    [rowpcb, colpcb] = size(pcb);
    [rowic, colic] = size(ic);
    for i = 1:(rowpcb - rowic)
        for j = 1:(colpcb - colic)
            a = double(ic);
            b = double(pcb(i:(i + rowic - 1), j:(j + colic - 1)));
            makhraj = sqrt(sum(sum(a .* a)) * sum(sum(b .* b)));
            soorat = sum(sum(a .* b));
            coff = soorat / makhraj;
            if coff >= 0.9
                rectangle('Position', [j, i, colic, rowic], 'EdgeColor', edgeColor, 'LineWidth', 3);
            end
        end
    end
end

% Calling function
findMatches(PCB, IC, 'r');
IC=imrotate(IC,180);
findMatches(PCB,IC, 'g');
