% Routh stability criteria table generator

% run the program and follow intructions

% Author: aniket awati [ aniketawati2050@gmail.com ]
function []= routh()
p=input('Enter highest power'); %p  gives highes power
syms e;
x=e; % x stores the coefficients
for i=1:(p+1)
x(i)=input('Enter coefficients (highest first):');
end
j=1;
% this block gets value of the columns of the routh table
if mod(p,2)==0
    r=(p+2)/2;
else
    r=(p+1)/2;
end
d=zeros(p+1,r);
s=e; % actual table is saved in this variable
k=1;
%this block arranges first two ros of the table
for i=1:(p+1)
   if mod(i,2)==1
        s(1,j)=x(i);
        j=j+1;
    else
        s(2,k)=x(i);
        k=k+1;
   end
end
% initialisation for remaining places
for i=3:(p+1)
    for j=1:r
        s(i,j)=0;
    end
end
% actual calculations and condition checks that utimately give routh table
for i=3:(p+1)
    for j=1:(r-1)
        s(i,j)=(s(i-1,1)*s(i-2,j+1)-s(i-1,j+1)*s(i-2,1))/s(i-1,1);
    end
    if s(i,:)==d(i,:)        
        for k=1:r-1
            if(p-i+2-2*(k-1))>=0
                s(i,k)=(p-i+2-2*(k-1))*s(i-1,k);
            else
                break;
            end
        end
    end
    if s(i,1)==0
        s(i,1)=e;
    end
end
disp('Routh Table :');
pretty(simplify(s));
aflg=0;
flg=0;
% check for sign changes and stability considerations
for i=1:p+1
    x=abs(s(i,1));
    a=limit(x,e,0);
    y=s(i,1);
    b=limit(y,e,0);    
    if a~=b
        if aflg==0
            aflg=1;
            flg=flg+1;
        end
    else
        if aflg==1
            aflg=0;
            flg=flg+1;
        end
    end
end
% comments on the table
if flg>0
[st,er]=sprintf('\n %d sign changes due to poles in rhp and hence system is unstable',flg);
else
[st,er]=sprintf('\n No sign changes and hence system in stable');
end
disp(st);

%sample run : for characteristic equation  s^5+2*s^4+3*s^3+5*s^2+2*s+3 
% >> routh
% Enter highest power5
% Enter coefficients (highest first):1
% Enter coefficients (highest first):2
% Enter coefficients (highest first):3
% Enter coefficients (highest first):5
% Enter coefficients (highest first):2
% Enter coefficients (highest first):3
% Routh Table :
 
 %                    [ 1      3     2]
 %                    [               ]
 %                    [ 2      5     3]
 %                    [               ]
 %                    [1/2    1/2    0]
 %                    [               ]
 %                    [ 3      3     0]
 %                    [               ]
 %                    [ 6      0     0]
 %                    [               ]
 %                    [ 3      0     0]

%  No sign changes and hence system in stable
