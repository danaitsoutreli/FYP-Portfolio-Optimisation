function FLM_Error_Plot(Normalised_FLM_Error,n,k,Level_of_noise,N)

figure();
hold on;
grid on;
grid(gca,'minor');
% Plot
plot((1:N),(Normalised_FLM_Error),'Linewidth' ,1);
legend ('Normalised FLM Error');
title({['Factor Loading Matrix Estimation Error'];['(Days = ', num2str(N),', Assets = ',num2str(n), ', Factors = ', num2str(k), ', Noise = ', num2str(Level_of_noise),')']});
xlabel('Number of Days');
ylabel('FLM Error');
ax = gca;
ax.YAxis.Exponent = 0;
% Set Font Name and Font Size
set(gca, 'FontName', 'Times New Roman'); 
set(gca, 'FontSize', 20);
hold off;
end