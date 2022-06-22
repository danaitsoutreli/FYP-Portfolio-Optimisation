function Returns_Error_Plot(Returns_Error_FLM_actual, Returns_Error_FLM_est, N, n, k, Level_of_noise)

figure();
hold on;
grid on;
grid(gca,'minor');

% Plot
plot((1:N),(Returns_Error_FLM_actual),'Linewidth',1);
plot((1:N),(Returns_Error_FLM_est),'Linewidth',1);
legend ('Returns Error - {\itFLM_{actual}}','Returns Error - {\itFLM_{est}}');

title({['Normalised Returns Error'];['(Days = ', num2str(N),', Assets = ',num2str(n), ', Factors = ', num2str(k), ', Noise = ', num2str(Level_of_noise),')']});
xlabel('Number of Days');
ylabel('Returns Error');
ax = gca;
ax.YAxis.Exponent = 0;
% Set Font Name and Font Size
set(gca, 'FontName', 'Times New Roman'); 
set(gca, 'FontSize', 20);
hold off;

end
