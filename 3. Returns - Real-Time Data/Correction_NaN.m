function [Corrected_Vector] = Correction_NaN (Corrected_Vector,N)

for i = 1:N-1
    TF = isnan(Corrected_Vector(:,i));
    if TF == 1
      Corrected_Vector(:,i) = abs(Corrected_Vector(:,i-1)+Corrected_Vector(:,i+1))/2;
    end
end

for i = 1:N-1
    TF = isinf(Corrected_Vector(:,i));
    if TF == 1
      Corrected_Vector(:,i) = abs(Corrected_Vector(:,i-1)+Corrected_Vector(:,i+1))/2;
    end
end

end