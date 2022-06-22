function [Output] = Dimension_transformation(Input)

    % (axb) matrix --> (abx1) matrix
    Output = [];
    [~,a] = size(Input);

    for i = 1:a
        [Output] = vertcat(Output,Input(:,i));
    end
    
end