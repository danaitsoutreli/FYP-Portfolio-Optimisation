function Returns_Error_Plot_Real_Data(Returns_Error_CVX,Returns_Error_EM, N, n, k, Level_of_noise)

figure();
hold on;
grid on;
grid(gca,'minor');
% Plot
plot((1:N),(Returns_Error_CVX),'Linewidth',1);
plot((1:N),(Returns_Error_EM),'Linewidth',1);
legend ('Returns Error - {\itFLM_{CVX}}', 'Returns Error - {\itFLM_{EM}}');
title({['Normalised Returns Error'];['(Days = ',num2str(N),', Assets = ', num2str(n), ', Factors = ', num2str(k), ', Noise = ', num2str(Level_of_noise),')']});
xlabel('Number of Days');
ylabel('Returns Error');
ax = gca;
ax.YAxis.Exponent = 0;
% Set Font Name and Font Size
set(gca, 'FontName', 'Times New Roman'); 
set(gca, 'FontSize', 20);
hold off;

end
