function Returns_Plot(Actual_Returns,Returns_Error_FLM_actual,Returns_Error_FLM_est,n,k,Level_of_noise, N)

figure();
hold on;
grid on;
grid(gca,'minor');

% Plot
plot((1:N),(Actual_Returns),'Linewidth',1);
plot((1:N),(Returns_Error_FLM_actual),'Linewidth',1);
plot((1:N),(Returns_Error_FLM_est),'Linewidth',1);
legend ('Actual Returns','Predicted Returns - {\itFLM_{actual}}', 'Predicted Returns - {\itFLM_{est}}');
title({['Normalised Returns'];['(Days = ', num2str(N),', Assets = ',num2str(n), ', Factors = ', num2str(k), ', Noise = ', num2str(Level_of_noise),')']});
xlabel('Number of Days');
ylabel('Normalised Returns');
ax = gca;
ax.YAxis.Exponent=0;

% Set Font Name and Font Size
set(gca, 'FontName', 'Times New Roman'); 
set(gca, 'FontSize', 20);
hold off;

end