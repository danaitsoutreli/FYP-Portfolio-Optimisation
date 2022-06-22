% function Returns_Plot_Real_Data(Actual_Returns,Predicted_Returns,n,k,Level_of_noise, N)
% 
% figure();
% hold on;
% grid on;
% grid(gca,'minor');
% 
% % Plot
% plot((1:N),   Actual_Returns(:,(1:N))*100,'Linewidth',1);
% plot((1:N),Predicted_Returns(:,(1:N))*100,'Linewidth',1);
% 
% legend ('Actual Returns','Predicted Returns - {\itFLM_{CVX,EM}}');
% title({['Normalised Returns'];['(Days = ',num2str(N),', Assets = ', num2str(n), ', Factors = ', num2str(k), ', Noise = ', num2str(Level_of_noise),')']});
% xlabel('Number of Days');
% ylabel('Normalised Returns');
% 
% ax = gca;
% ax.YAxis.Exponent = 0;
% 
% % Set Font Name and Font Size
% set(gca, 'FontName', 'Times New Roman'); 
% set(gca, 'FontSize', 20);
% hold off;
% 
% end

function Returns_Plot_Real_Data(Actual_Returns,Predicted_Returns,n,k,Level_of_noise, N)

figure();
hold on;
grid on;
grid(gca,'minor');

% Plot
plot((1:N),   Actual_Returns(:,(1:N))*100,'Linewidth',1);
plot((1:N),Predicted_Returns(:,(1:N))*100,'Linewidth',1);

legend ('Actual Returns','Predicted Returns');
title({['Portfolio Returns'];['{\it 10 Random Assets from the FTSE 100 Index}']});
xlabel('Number of Days');
ylabel('Portfolio Returns');

ax = gca;
ax.YAxis.Exponent = 0;

% Set Font Name and Font Size
set(gca, 'FontName', 'Times New Roman'); 
set(gca, 'FontSize', 25);
hold off;

end