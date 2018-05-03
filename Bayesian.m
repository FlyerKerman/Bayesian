mu1=mean(omega1);
mu2=mean(omega2);
sigma1=std(omega1);
sigma2=std(omega2);%在已知数据集服从正态分布的情况下，直接计算平均值和方差
lambda=[0 6;1 0];
px=pw1*normpdf(x,mu1,sigma1)+pw2*normpdf(x,mu2,sigma2);
pw1x=(normpdf(x,mu1,sigma1)*pw1)/px;
pw2x=(normpdf(x,mu2,sigma2)*pw2)/px;
Ra1x=lambda(1,1)*pw1x+lambda(1,2)*pw2x;
Ra2x=lambda(2,1)*pw1x+lambda(2,2)*pw2x;
if pw1x>pw2x%给出最小错误率决策
    fprintf('Ignoring all the risks,this is a normal cell\n');
else
    fprintf('Ignoring all the risks,this is an abnormal cell\n');
end
if Ra1x<Ra2x%给出最小风险决策
    fprintf('Considering all the risks,this is a normal cell.\n');
    y=0;
else
    fprintf('Considering all the risks,this is an abnormal cell\n');
    y=1;
end
x1=-10:0.01:10;
px1=pw1*normpdf(x1,mu1,sigma1)+pw2*normpdf(x1,mu2,sigma2);%画出各先验概率和后验概率以及各类决策风险的图
subplot(3,2,1);plot(x1,normpdf(x1,mu1,sigma1));
title('p(X|w1)');xlabel('x');ylabel('p');
subplot(3,2,2);plot(x1,normpdf(x1,mu2,sigma2));
title('p(X|w2)');xlabel('x');ylabel('p');
subplot(3,2,3);plot(x1,(normpdf(x1,mu1,sigma1)*pw1)./px1);
title('p(w1|X)');xlabel('x');ylabel('p');
subplot(3,2,4);plot(x1,(normpdf(x1,mu2,sigma2)*pw2)./px1);
title('p(w2|X)');xlabel('x');ylabel('p');
subplot(3,2,5);plot(x1,lambda(1,2)*(normpdf(x1,mu2,sigma2)*pw2)./px1);
title('R(a1|x)');xlabel('x');ylabel('r');
subplot(3,2,6);plot(x1,lambda(2,1)*(normpdf(x1,mu1,sigma1)*pw1)./px1);
title('R(a2|x)');xlabel('x');ylabel('r');
figure(2);%将两类的后验概率画在同一张图中以便给出决策边界
hold on;
plot(x1,(normpdf(x1,mu1,sigma1)*pw1)./px1);
plot(x1,(normpdf(x1,mu2,sigma2)*pw2)./px1);
legend('p(w1|X)','p(w2|X)');
figure(3);%将两类的决策风险画在同一张图中以便给出决策边界
hold on;
plot(x1,lambda(1,2)*(normpdf(x1,mu2,sigma2)*pw2)./px1);
plot(x1,lambda(2,1)*(normpdf(x1,mu1,sigma1)*pw1)./px1);
legend('R(a1|x)','R(a2|x)');
