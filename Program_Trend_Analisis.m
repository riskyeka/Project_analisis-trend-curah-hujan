%% Import data curah hujan
clc
clear
disp('PROGRAM ANALISIS TREND DATA CURAH HUJAN PERBULAN TAHUN 2018 DAN 2019') 
disp('====================================================================')
DH_2018 = xlsread('2018');
DH_2019 = xlsread('2019');
%% Seleksi data import
k=1;
for j=2:13
    DH_18y(k)=DH_2018(j);
    DH_19y(k)=DH_2019(j);
    k=k+1;
end
%% Inisialisasi variabel yang digunakan
x = 1:12;
N = 12;

sumxy_18=0;
sumx_18=0;
sumy_18=0;
sumxx_18=0;
sumyy_18=0;

sumxy_19=0;
sumx_19=0;
sumy_19=0;
sumxx_19=0;
sumyy_19=0;
%% Menghitung analisis data curah hujan dengan metode regresi linier
for i=1:N
    sumxy_18=sumxy_18+(x(i)*DH_18y(i));
    sumx_18=sumx_18+x(i);
    sumy_18=sumy_18+DH_18y(i);
    sumxx_18=sumxx_18+(x(i)*x(i));
    sumyy_18=sumyy_18+(DH_18y(i)*DH_18y(i));
    
    sumxy_19=sumxy_19+(x(i)*DH_19y(i));
    sumx_19=sumx_19+x(i);
    sumy_19=sumy_19+DH_19y(i);
    sumxx_19=sumxx_19+(x(i)*x(i));
    sumyy_19=sumyy_19+(DH_19y(i)*DH_19y(i));
end

bil_18=(N*sumxy_18)-(sumx_18*sumy_18);
but_18=(N*sumxx_18)-(sumx_18*sumx_18);
bit_18=(N*sumyy_18)-(sumy_18*sumy_18);
m_18=bil_18/but_18;
bagi_18=sumy_18/N;
kali_18=(m_18*sumx_18)/N;
c_18=bagi_18-kali_18;
akar_18=sqrt(but_18*bit_18);
RMSE_18=bil_18/akar_18;
fprintf('Nilai m 2018 adalah %f\n', m_18)
fprintf('Nilai c 2018 adalah %f\n', c_18)
fprintf('Nilai Koefisien Korelasi 2018 atau RMSE 2018 adalah %f\n', RMSE_18)

bil_19=(N*sumxy_19)-(sumx_19*sumy_19);
but_19=(N*sumxx_19)-(sumx_19*sumx_19);
bit_19=(N*sumyy_19)-(sumy_19*sumy_19);
m_19=bil_19/but_19;
bagi_19=sumy_19/N;
kali_19=(m_19*sumx_19)/N;
c_19=bagi_19-kali_19;
akar_19=sqrt(but_19*bit_19);
RMSE_19=bil_19/akar_19;
fprintf('\nNilai m 2019 adalah %f\n', m_19)
fprintf('Nilai c 2019 adalah %f\n', c_19)
fprintf('Nilai Koefisien Korelasi 2019 atau RMSE 2019 adalah %f\n', RMSE_19)
%% Memasukkan data hasil analisis regresi linier kedalam persamaan garis
maks=max(x);
step=1:maks;
for a=1:length(step)
    F_18(a)=(m_18*step(a))+c_18;
    F_19(a)=(m_19*step(a))+c_19;
    d(a)=a;
end
%% Menampilkan data dalam sebuah tabel
No = d';
X = step';
H_2018 = F_18';
H_2019 = F_19';
Tabel = table(No,X,H_2018,H_2019)
%% Ploting data untuk menampilkan grafik
plot(x,DH_18y,'c',x,DH_19y,'g',step,F_18,'r',step,F_19,'b',x,DH_18y,'*',x,DH_19y,'*','lineWidth',2)
grid on;
xlabel('Bulan')
ylabel('Data Curah Hujan (per Bulan)')
title('Grafik Analisis Trend Curah Hujan per Bulan Kab. Kediri Tahun 2018 dan 2019')
legend('Data Curah Hujan 2018','Data Curah Hujan 2019','Hasil Analisis Curah Hujan 2018','Hasil Analisis Curah Hujan 2019')
