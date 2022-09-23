%% Demo code for training and testing the CDFTSVM on an artifical dataset
clc
clear

Kernel.Type = 'RBF';
QPPs_Solver = 'QP_Matlab';

%% load train data
load data/synthtr
synthtr(find(synthtr(:,end)==0),end)=-1;

Samples_Train=synthtr(:,1:2);
Labels_Train=synthtr(:,3);

%% load test data
load data/synthte
synthte(find(synthte(:,end)==0),end)=-1;

Samples_Predict=synthte(:,1:2);
Labels_Predict=synthte(:,3);


I_A = Labels_Train == 1;
Samples_A = Samples_Train(I_A,:);
Labels_A = Labels_Train(I_A);

I_B = Labels_Train == -1;
Samples_B = Samples_Train(I_B,:);                        
Labels_B = Labels_Train(I_B);   

Kernel.gamma = 2^0;

s = DC_IFuzzy_MemberShip(Samples_Train, Labels_Train, Kernel); 


gamma_Interval = 2.^(-5:-4);
lambda1_Interval = 2.^(-8:-7);
lambda2_Interval = 2.^(-8:-7);
C1_Interval = 2.^(-8:-7);
C3_Interval = 2.^(-8:-7);


C1 = 2^0;
C2 = 2^0;
C3 = 2^0;
C4 = 2^0;

lambda1 = 2^0;
lambda2 =2^0;
C_s.C1 = C1;
C_s.C2 = C2;
C_s.s1 = s.s1;
C_s.s2 = s.s2;
C_s.C3 = C3;
C_s.C4 = C4;





tic
Outs_Train = Train_FTBLDM(Samples_A, Labels_A, Samples_B,Labels_B, Samples_Train, lambda1,lambda2 , C_s, Kernel, QPPs_Solver);
t = toc;
Acc = Predict_FTBLDM(Outs_Train, Samples_Predict,Labels_Predict, Samples_Train);   

disp(['  The predicting accurate is: ', num2str(100*Acc), '%']);
disp(['  The training time is ', num2str(t), ' seconds.'])
