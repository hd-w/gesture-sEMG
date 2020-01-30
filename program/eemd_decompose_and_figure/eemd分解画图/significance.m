
%   function [sigline, logep] = significance(imfs, percenta)
%
%	that is used to obtain the "percenta" line based on Wu and
%	Huang (2004).
%
%   NOTE:   For this program to work well, the minimum data length is 36
%
%   INPUT:
%	    percenta: a parameter having a value between 0.0 ~ 1.0, e.g., 0.05 
%                 represents 95% confidence level (upper bound); and 0.95 
%                 represents 5% confidence level (lower bound) 
%       imfs:     the true IMFs from running EMD code. The first IMF must
%                 be included for it is used to obtain the relative mean
%                 energy for other IMFs. The trend is not included.
%   OUTPUT:
%       sigline:  a two column matrix, with the first column the natural
%                 logarithm of mean period, and the second column the
%                 natural logarithm of mean energy for significance line
%       logep:    a two colum matrix, with the first column the natural
%                 logarithm of mean period, and the second column the
%                 natural logarithm of mean energy for all IMFs
%
% References can be found in the "Reference" section.
%
% The code is prepared by Zhaohua Wu. For questions, please read the "Q&A" section or
% contact
%   zhwu@cola.iges.org
%
function [sigline, logep] = significance(imfs, percenta)

nDof = length(imfs(:,1));
pdMax = fix(log(nDof))+1;

pdIntv = linspace(1,pdMax,100);
yBar = -pdIntv;

for i=1:100,
    yUpper(i)=0;
    yLower(i)= -3-pdIntv(i)*pdIntv(i);
end

for i=1:100,
    sigline(i,1)=pdIntv(i);
    
    yPos=linspace(yUpper(i),yLower(i),5000);
    dyPos=yPos(1)-yPos(2);
    yPDF=dist_value(yPos,yBar(i),nDof);
    
    sum = 0.0;
    for jj=1:5000,
        sum = sum + yPDF(jj);
    end
    
    jj1=0;
    jj2=1;
    psum1=0.0;
    psum2=yPDF(1);
    pratio1=psum1/sum;
    pratio2=psum2/sum;
    
    while pratio2 < percenta,
        jj1=jj1+1;
        jj2=jj2+1;
        psum1=psum1+yPDF(jj1);
        psum2=psum2+yPDF(jj2);
        pratio1=psum1/sum;
        pratio2=psum2/sum;
        yref=yPos(jj1);
    end
    sigline(i,2) = yref + dyPos*(pratio2-percenta)/(pratio2-pratio1);
    sigline(i,2) = sigline(i,2) + 0.066*pdIntv(i) + 0.12;
end
sigline=1.4427*sigline;

columns=length(imfs(1,:));
for i=1:columns,
    logep(i,2)=0;
    logep(i,1)=0;
    for j=1:nDof,
        logep(i,2)=logep(i,2)+imfs(j,i)*imfs(j,i);
    end
    logep(i,2)=logep(i,2)/nDof;
end

sfactor=logep(1,2);
for i=1:columns,
    logep(i,2)=0.5636*logep(i,2)/sfactor;  % 0.6441
end

for i=1:3,
    [spmax, spmin, flag]= extrema(imfs(:,i));
    temp=length(spmax(:,1))-1;
    logep(i,1)=nDof/temp;
end
for i=4:columns,
    omega=ifndq(imfs(:,i),1);
    sumomega=0;
    for j=1:nDof,
        sumomega=sumomega+omega(j);
    end
    logep(i,1)=nDof*2*pi/sumomega;
end
logep=1.4427*log(logep);
        


      
