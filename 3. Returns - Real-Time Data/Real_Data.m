function [Returns, Factors] = Real_Data()

% Daily returns (95 stocks)
Returns = readtable('Financial_Dataset.xlsx','sheet',2,'Range', 'B8:CR341');
Returns = table2array(Returns(~any(ismissing(Returns),2),:)); 
Returns = Returns'; %(101x334)

% Load the factors
Factors = readtable('Financial_Dataset.xlsx','sheet',3,'Range','G4:L341');
Factors = table2array(Factors(~any(ismissing(Factors),2),:));
Factors = Factors'; %(6x334)

end