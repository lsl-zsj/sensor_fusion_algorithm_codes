function EMI_test()


clear all
addpath('D:\Work\Task\IMU_Code\IMU_Test_Data\xsens');
addpath(genpath('D:\Work\Task\IMU_Code\IMU-Matlab'));

load('gait_0.1_magd.mat');
IMU=gait;

len=length(IMU.Acceleration);
fs=IMU.fs;
S=zeros(len,10);
S(:,1)=(1:len)';
S(:,2:10)=[IMU.Acceleration,IMU.Gyroscope,IMU.Magnetic];

tauAcc= 0.2;
tauMag= 10;
zeta= 0.3;
accRating= 1;

qin1=[1 0 0 0];
q1 = runOriEstIMU(S(:,2:4), S(:,5:7), S(:,8:10), fs, tauAcc, tauMag, zeta, accRating, qin1);

for i=1:length(q1)
Quat(i)=quaternion(q1(i,1),q1(i,2),q1(i,3),q1(i,4));
end

euler=eulerd(Quat,'ZXY','frame');

figure
plot(euler)

end
