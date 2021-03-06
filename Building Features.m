%% check 
for i=1:697
plot(X(1:280,i))
title(i);
pause;
end
%% initial %%
clear;
clc;
load('Building Features.mat');%attention?Matrix data are column vector
row=size(X,1);%Indicator
column=size(X,2);%number of vector(experiment vector in different situation)
row_r=280;%Original Data
XX=1:280;
%% integraw 281 %%234
X(row+1,:)=sum(X,1);
row=size(X,1);
%% Length 282 %%236
C=zeros(1,column);
for i=1:column
    num=0;
    for j=1:row_r
        if (X(j,i)~=0)
        num=num+1;
        end
    end
    C(1,i)=num;
end
X(row+1,:)=C;
row=size(X,1);
%% Average 283 %%237
X(row+1,:)=X(row-1,:)./X(row,:);
row=size(X,1);
%% Maximum 284 %%238
C=max(X(1:row_r,:),[],1);
X(row+1,:)=C;
row=size(X,1);
%% RMS(Include Zero) 285 %%239
C=rms(X(1:row_r,:));
X(row+1,:)=C;
row=size(X,1);
%% RMS(Not Include Zero) 286 %%240
C=X(1:row_r,:);
C=C.^2;
C=sum(C, 1);
C=C./X(282,:);
C=sqrt(C);
X(row+1,:)=C;
row=size(X,1);
%% Peak Xp(The Average of 15 Biggest Data Point) 287 %%241
C=X(1:row_r,:);
C=sort(C);
C=C((row_r-15):row_r,:);
C=mean(C,1);
X(row+1,:)=C;
row=size(X,1);
%% Peak Xp(The Average of 5 Biggest Data Point) 288 %%241
C=X(1:row_r,:);
C=sort(C);
C=C((row_r-5):row_r,:);
C=mean(C,1);
X(row+1,:)=C;
row=size(X,1);
%% Peak Xp(The Average of 3 Biggest Data Point) 289 %%241
C=X(1:row_r,:);
C=sort(C);
C=C((row_r-3):row_r,:);
C=mean(C,1);
X(row+1,:)=C;
row=size(X,1);
%% Peak Indicator-15 Ip 290 %%242
X(row+1,:)=X(287,:)./X(286,:);
row=size(X,1);
%% Peak Indicator-5 Ip 291 %%242
X(row+1,:)=X(288,:)./X(286,:);
row=size(X,1);
%% Peak Indicator-3 Ip 292 %%242
X(row+1,:)=X(289,:)./X(286,:);
row=size(X,1);
%% Pulse Indicator Cf 293 %%243-5
X(row+1,:)=X(288,:)./X(283,:);
row=size(X,1);
%% Margin Indicator Ce 294 %%244
X(row+1,:)=X(286,:)./X(283,:);
row=size(X,1);
%% Cw 295 %245
C=X(1:row_r,:);
for i=1:row_r
    for j=1:column
        if C(i,j)~=0
        C(i,j)=C(i,j)-X(283,j);
        end
    end
end
C=C.^3;
C=sum(C, 1);
C=C./X(282,:);
D=X(286,:).^3;
X(row+1,:)=C./D;
row=size(X,1);
%% Cq 296 %%246
C=X(1:row_r,:);
for i=1:row_r
    for j=1:column
        if C(i,j)~=0
        C(i,j)=C(i,j)-X(283,j);
        end
    end
end
C=C.^4;
C=sum(C, 1);
C=C./X(282,:);
D=X(286,:).^4;
X(row+1,:)=C./D;
row=size(X,1);
%% Histogram 297-317 %%247-267 !!Not Included!!
C=zeros(21,column);
for i=1:row_r
    for j=1:column
        if X(i,j)~=0
            if X(i,j)>=1000
               C(21,j)=C(21,j)+1;
            else 
               C(ceil(X(i,j)/50),j)=C(ceil(X(i,j)/50),j)+1;
            end
        end
    end
end
X=[X;C];
row=size(X,1);
%% Close Average Curve Av_c %%
Av_c=zeros(row_r,1);
num=0;
for i=1:column
    if Y(1,i)==0
        Av_c=Av_c+X(1:row_r,i);
        num=num+1;
    end
end
Av_c=Av_c./num;
%% Open Average Curve Av_o %%
Av_o=zeros(row_r,1);
num=0;
for i=1:column
    if Y(1,i)==1
        Av_o=Av_o+X(1:row_r,i);
        num=num+1;
    end
end
Av_o=Av_o./num;
%% Average Curve Av %%
Av=zeros(row_r,1);
num=0;
for i=1:column
    if (Y(1,i)==0||Y(1,i)==1)
        Av=Av+X(1:row_r,i);
        num=num+1;
    end
end
Av=Av./num;
%% Residual Error Sum Close & Open 318 %%
D=zeros(1,column);
for i=1:column
    if (Y(1,i)<=1)
       if Y(1,i)==0
           C=X(1:row_r,i)-Av_c;
           C=abs(C);
           D(1,i)=sum(C);
       else
           C=X(1:row_r,i)-Av_o;
           C=abs(C);
           D(1,i)=sum(C);
       end
    else 
       C=X(1:row_r,i)-Av;
       C=abs(C);
       D(1,i)=sum(C);
    end
end
X(row+1,:)=D;
row=size(X,1);
%% root mean square error RMSE 319 %%
D=zeros(1,column);
for i=1:column
    if (Y(1,i)<=1)
       if Y(1,i)==0
           C=X(1:row_r,i)-Av_c;
           C=C.^2;
           D(1,i)=sqrt(sum(C)/row_r);
       else
           C=X(1:row_r,i)-Av_o;
           C=C.^2;
           D(1,i)=sqrt(sum(C)/row_r);
       end
    else 
       C=X(1:row_r,i)-Av;
       C=C.^2;
       D(1,i)=sqrt(sum(C)/row_r);
    end
end
X(row+1,:)=D;
row=size(X,1);
%% index of max A Point 320 %% 
[i,ii]=max(X(1:20,:));
X(row+1,:)=ii;
row=size(X,1);
%% index of B point 321 %%
C=zeros(1,column);
for i=1:column
    for j=0:40
        if X(X(320,i)+j,i)-X(X(320,i)+j+3,i)>10
            C(1,i)=X(320,i)+j+1;
        end
    end
end
X(row+1,:)=C;
row=size(X,1);
%% index of D Point 322 %%
C=zeros(1,column);
for i=1:column
    for j=0:12
        if X(X(282,i)-2-j,i)-X(X(282,i)-j,i)>7
            C(1,i)=X(282,i)-j-1;
        end
    end
end
X(row+1,:)=C;
row=size(X,1);
%% index of C Point 323 %%
C=zeros(1,column);
C=X(321,:)+floor((X(322,:)-X(321,:))./2);
X(row+1,:)=C;
row=size(X,1);
%% check curve point
for i=1:column
    plot(X(1:280,i));
    title(i);
    hold on
    plot(X(320,i),X(X(320,i),i),'*');
    plot(X(321,i),X(X(321,i),i),'*');
    plot(X(322,i),X(X(322,i),i),'*');
    hold off
    pause;
end
%% Av curve 
%Average
Av_A_A=mean(Av(1:7));
Av_B_A=mean(Av(7:28));
Av_C_A=mean(Av(28:121));
Av_D_A=mean(Av(121:214));
Av_E_A=mean(Av(214:247));
%slope
p=polyfit(XX(1:7),Av(1:7)',1);
Av_A_S=p(1);
p=polyfit(XX(7:28),Av(7:28)',1);
Av_B_S=p(1);
p=polyfit(XX(214:247),Av(214:247)',1);
Av_E_S=p(1);
%% A part Average Slope, Average error,Slope error %%
%324 slope
C=zeros(1,column);
for i=1:column
     p=polyfit(XX(1:X(320,i)),X(1:X(320,i),i)',1);
     C(1,i)=p(1);  
end
X(row+1,:)=C;
row=size(X,1);
%325 mean
C=zeros(1,column);
for i=1:column
     C(1,i)=mean(X(1:X(320,i),i)); 
end
X(row+1,:)=C;
row=size(X,1);
%326 slope error
C=zeros(1,column);
C=abs(X(324,:)-Av_A_S);
X(row+1,:)=C;
row=size(X,1);
%327 mean error
C=zeros(1,column);
C=abs(X(325,:)-Av_A_A);
X(row+1,:)=C;
row=size(X,1);
%% B part Average Slope, Average error,Slope error %%
%328 slope
C=zeros(1,column);
for i=1:column
     p=polyfit(XX(X(320,i):X(321,i)),X(X(320,i):X(321,i),i)',1);
     C(1,i)=p(1);  
end
X(row+1,:)=C;
row=size(X,1);
%329 mean
C=zeros(1,column);
for i=1:column
     C(1,i)=mean(X(X(320,i):X(321,i),i)); 
end
X(row+1,:)=C;
row=size(X,1);
%330 slope error
C=zeros(1,column);
C=abs(X(328,:)-Av_B_S);
X(row+1,:)=C;
row=size(X,1);
%331 mean error
C=zeros(1,column);
C=abs(X(329,:)-Av_B_A);
X(row+1,:)=C;
row=size(X,1);
%% C part Average Average error %%
%332 mean
C=zeros(1,column);
for i=1:column
     C(1,i)=mean(X(X(321,i):X(323,i),i)); 
end
X(row+1,:)=C;
row=size(X,1);
%333 mean error
C=zeros(1,column);
C=abs(X(332,:)-Av_C_A);
X(row+1,:)=C;
row=size(X,1);
%% D part Average Average error %%
%334 mean
C=zeros(1,column);
for i=1:column
     C(1,i)=mean(X(X(323,i):X(322,i),i)); 
end
X(row+1,:)=C;
row=size(X,1);
%335 mean error
C=zeros(1,column);
C=abs(X(334,:)-Av_D_A);
X(row+1,:)=C;
row=size(X,1); 
%% E part Average Slope, Average error,Slope error %%
%336 slope
C=zeros(1,column);
for i=1:column
     p=polyfit(XX(X(322,i):X(282,i)),X(X(322,i):X(282,i),i)',1);
     C(1,i)=p(1);  
end
X(row+1,:)=C;
row=size(X,1);
%337 mean
C=zeros(1,column);
for i=1:column
     C(1,i)=mean(X(X(322,i):X(282,i),i)); 
end
X(row+1,:)=C;
row=size(X,1);
%338 slope error
C=zeros(1,column);
C=abs(X(336,:)-Av_E_S);
X(row+1,:)=C;
row=size(X,1);
%339 mean error
C=zeros(1,column);
C=abs(X(337,:)-Av_E_A);
X(row+1,:)=C;
row=size(X,1);
%% 240/15 average 340-354 %% 353,354!!Not Included!!
C=zeros(15,column);
for i=1:15
    C(i,:)=mean(X(((i*16)-15):(i*16),:));
end
X=[X;C];
row=size(X,1);
%% 240/10 average 355-364 %%
C=zeros(10,column);
for i=1:10
    C(i,:)=mean(X(((i*24)-23):(i*24),:));
end
X=[X;C];
row=size(X,1);
%% 240/5 average 365-369 %%
C=zeros(5,column);
for i=1:5
    C(i,:)=mean(X(((i*48)-47):(i*48),:));
end
X=[X;C];
row=size(X,1);
%% 0 Point to B Point curve 2 degree fitting 370-372 %%
C=zeros(3,column);
for i=1:column
     p=polyfit(XX(1:X(321,i)),X(1:X(321,i),i)',2);
     C(:,i)=p';  
end
X=[X;C];
row=size(X,1);
%% C-D segment Absolute Value of Each 1 Power Value Difference Sum 373 %%
C=zeros(1,column);
for i=1:column
    num=0;
    for j=X(321,i):X(322,i)-1
        num=num+abs(X(j,i)-X(j+1,i));
    end
    C(1,i)=num;
end
X=[X;C];
row=size(X,1);
%% C-D segment Absolute Value of Each 2 Power Value Difference Sum 374 %%
C=zeros(1,column);
for i=1:column
    num=0;
    for j=X(321,i):X(322,i)-2
        num=num+abs(X(j,i)-X(j+2,i));
    end
    C(1,i)=num;
end
X=[X;C];
row=size(X,1);
%% C-D segment Absolute Value of Each 3 Power Value Difference Sum 375 %%
C=zeros(1,column);
for i=1:column
    num=0;
    for j=X(321,i):X(322,i)-3
        num=num+abs(X(j,i)-X(j+3,i));
    end
    C(1,i)=num;
end
X=[X;C];
row=size(X,1);
%% C-D segment Absolute Value of Each 4 Power Value Difference Sum 376 %%
C=zeros(1,column);
for i=1:column
    num=0;
    for j=X(321,i):X(322,i)-4
        num=num+abs(X(j,i)-X(j+4,i));
    end
    C(1,i)=num;
end
X=[X;C];
row=size(X,1);
%% C-D segment Absolute Value of Each 5 Power Value Difference Sum 377 %%
C=zeros(1,column);
for i=1:column
    num=0;
    for j=X(321,i):X(322,i)-5
        num=num+abs(X(j,i)-X(j+5,i));
    end
    C(1,i)=num;
end
X=[X;C];
row=size(X,1);

%% Hist %%
hi=zeros(377,1);
is=zeros(377,1);
j=1;
k=1;
for i=1:column
        if Y(1,i)==1%%open
            hi=[hi,X(:,i)];
            indo(1,j)=i;
            j=j+1;
        end
        if Y(1,i)==0%close
            is=[is,X(:,i)];
            indc(1,k)=1;
            k=k+1;
        end
end
%% Gaussian Check %%
for i=281:377
    if Included(i,1)==1
        histogram(abs(X(i,Y(1,:)==1)).^Gaus_O(i,1),50)
        title(i)
        pause
        histogram(abs(X(i,Y(1,:)==0)).^Gaus_C(i,1),50)
        title(i)
        pause
    end
end
%  
for i=1:377
hii(i,:)=(hi(i,:).^Gaus_O(i,1)).*Included(i,1);
isi(i,:)=(is(i,:).^Gaus_C(i,1)).*Included(i,1);
end
%isi
for i=281:377
histogram(abs(isi(i,:)),50)
title(i)
pause
end
%
for i=281:377
histogram(abs(hii(i,:)),50)
title(i)
pause
end
%strange data check
for i=1:324
    if hii(332,i)>1
        ans=i
    end
end
%
faultcheck_hii=zeros(m,1);
[m,n] = size(hii);
fault_hii=zeros(1,n);
%
j=322
for i=1:324
    if hii(j,i)>faultcheck_hii(j,1)
        fault_hii(1,i)=fault_hii(1,i)+1;
    end
end

%% count different type of data
j=0;
for i=1:697
    if Y(1,i)>1
        j=j+1;
    end
end
%Training set: 386
%Cv set: 129 18
%Test set: 128 17
%% Split Dataset into two part: Normal Abnormal
% delete 1-19 column because capture speed too slow and data lenth too
% short
X_Normal=zeros(row,1);
X_Abnormal=zeros(row,1);
Y_Normal=0;
Y_Abnormal=0;
for i=1:column
    if Y(1,i)<2
        X_Normal=[X_Normal,X(:,i)];
        Y_Normal=[Y_Normal,Y(1,i)];
    else
        X_Abnormal=[X_Abnormal,X(:,i)];
        Y_Abnormal=[Y_Abnormal,Y(1,i)];
    end
end
%% Generate Random Index
%for normal data
[i,j]=size(X_Normal);
R=rand(1,j).*j;
[R_sort,R_index] = sort(R);
X_Normal_Rand=zeros(size(X_Normal));
Y_Normal_Rand=zeros(size(Y_Normal));
i=1;
for i=1:j
    X_Normal_Rand(:,i)=X_Normal(:,R_index(1,i));
    Y_Normal_Rand(:,i)=Y_Normal(:,R_index(1,i));
end
%for abnormal data
[i,j]=size(X_Abnormal);
R=rand(1,j).*j;
[R_sort,R_index] = sort(R);
X_Abnormal_Rand=zeros(size(X_Abnormal));
Y_Abnormal_Rand=zeros(size(Y_Abnormal));
i=1;
for i=1:j
    X_Abnormal_Rand(:,i)=X_Abnormal(:,R_index(1,i));
    Y_Abnormal_Rand(:,i)=Y_Abnormal(:,R_index(1,i));
end
%% Generate Training CV Test Set
[i,j]=size(X_Normal_Rand);
Training_Set_X=X_Normal_Rand(:,1:386);
Training_Set_Y=Y_Normal_Rand(:,1:386);
CV_Set_X=X_Normal_Rand(:,387:515);
CV_Set_Y=Y_Normal_Rand(:,387:515);
Test_Set_X=X_Normal_Rand(:,516:j);
Test_Set_Y=Y_Normal_Rand(:,516:j);
[i,j]=size(X_Abnormal_Rand);
CV_Set_X=[CV_Set_X,X_Abnormal_Rand(:,1:18)];
CV_Set_Y=[CV_Set_Y,Y_Abnormal_Rand(:,1:18)];
Test_Set_X=[Test_Set_X,X_Abnormal_Rand(:,19:j)];
Test_Set_Y=[Test_Set_Y,Y_Abnormal_Rand(:,19:j)];
%% From Datasets.dat: 
%% 计算将Feature转化为高斯分布的参数
%将Training CV test合并为一个变量
%all_X or Y:所有数据的集合，先是训练集再是交叉验证集，最后是检测集
all_X=[Training_Set_X,CV_Set_X,Test_Set_X];
all_Y=[Training_Set_Y,CV_Set_Y,Test_Set_Y];
X_normal=zeros(377,1);
X_anomaly=zeros(377,1);
X_normal=all_X(:,all_Y(1,:)==1);
X_normal=[X_normal,all_X(:,all_Y(1,:)==0)];
%% 生成新的曲线数据
[i,j]=size(X_normal);
New_Normal_X=buildingnews(X_normal,j,5,5,5,5,5,5,8,8,8,5,5,5);

