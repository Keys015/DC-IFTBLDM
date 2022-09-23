function [Acc,Label_Decision] = Predict_FTBLDM(Outs_Train, Samples_Predict, Labels_Predict,Samples_Train)




%% Main
   beta1 = Outs_Train.beta1; 
   beta2 = Outs_Train.beta2; 
   Kernel = Outs_Train.Kernel;
   K = Outs_Train.K;
   

   Label_Decision = -ones(length(Labels_Predict), 1);

   distance1 = abs(Function_Kernel(Samples_Predict, Samples_Train, Kernel)*beta1)/sqrt(beta1'*K*beta1);
   distance2 = abs(Function_Kernel(Samples_Predict, Samples_Train, Kernel)*beta2)/sqrt(beta2'*K*beta2);
   Value_Decision = distance1-distance2;
   
   Label_Decision(Value_Decision<=0) = 1;
   
 %------------Acc------------%
   Acc = sum(Label_Decision==Labels_Predict)/length(Labels_Predict);
   
 
end

