% this is a function to calculate instantaneous based on EMD method
%
%   function omega = ifndq(vimf, dt)
%
% INPUT:   
%          vimf:        an IMF;
%          dt:          time interval of the imputted data
% OUTPUT:
%          omega:       instantanesous frequency, which is 2*PI/T, where T
%                       is the period of an ascillation
%
% References can be found in the "Reference" section.
%
% The code is prepared by Zhaohua Wu. For questions, please read the "Q&A" section or
% contact
%   zhwu@cola.iges.org
%

function omega = ifndq(vimf, dt)
Nnormal=5;
rangetop=0.90;

vlength = max( size(vimf) );
vlength_1 = vlength -1;

for i=1:vlength,
    abs_vimf(i)=vimf(i);
    if abs_vimf(i) < 0
        abs_vimf(i)=-vimf(i);
    end
end

for jj=1:Nnormal,
    [spmax, spmin, flag]=extrema(abs_vimf);
    dd=1:1:vlength;
    upper= spline(spmax(:,1),spmax(:,2),dd);

    for i=1:vlength,
        abs_vimf(i)=abs_vimf(i)/upper(i);
    end
end

for i=1:vlength,
    nvimf(i)=abs_vimf(i);
    if vimf(i) < 0;
        nvimf(i)=-abs_vimf(i);
    end
end

for i=1:vlength,
    dq(i)=sqrt(1-nvimf(i)*nvimf(i));
end
for i=2:vlength_1,
    devi(i)=nvimf(i+1)-nvimf(i-1);
    if devi(i)>0 & nvimf(i)<1
        dq(i)=-dq(i);
    end
end

rangebot=-rangetop;     
for i=2:(vlength-1),
    if nvimf(i)>rangebot & nvimf(i) < rangetop
        omgcos(i)=abs(nvimf(i+1)-nvimf(i-1))*0.5/sqrt(1-nvimf(i)*nvimf(i));
    else
        omgcos(i)=-9999;
    end
end
omgcos(1)=-9999;
omgcos(vlength)=-9999;

jj=1;
for i=1:vlength,
    if omgcos(i)>-1000
        ddd(jj)=i;
        temp(jj)=omgcos(i);
        jj=jj+1;
    end
end
temp2=spline(ddd,temp,dd); 
omgcos=temp2;


for i=1:vlength,
    omega(i)=omgcos(i);
end

pi2=pi*2;
omega=omega/dt;
