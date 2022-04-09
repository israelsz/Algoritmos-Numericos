function createfigure1(YMatrix1)
%CREATEFIGURE4(YMatrix1)
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 14-Dec-2021 13:07:10

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0982291666666666 0.0908000000000001 0.775000000000001 0.815]);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(YMatrix1,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','Método Jacobi');
set(plot1(2),'DisplayName','Método Doolittle');
set(plot1(3),'DisplayName','Método Gram-Schmidt');

% Create ylabel
ylabel({'Tiempo [s]'},'FontSize',14);

% Create xlabel
xlabel('Iteración','FontSize',14);

% Create title
title('Costos temporales en segundos para cada método','FontSize',16);

hold(axes1,'off');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.879340280276825 0.83893333633741 0.110416664167618 0.108799996995925],...
    'FontSize',12);

