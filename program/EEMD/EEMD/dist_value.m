% This is a utility program being called by "significance.m".
%
%   function PDF = dist_value(yPos, yBar, nDof)
%

function PDF = dist_value(yPos, yBar, nDof)

%   function PDF = dist_value2(yPos, yBar, nDof)
%
%   PDF: a normalized output array 
%   yPos: An input array at which PDF values are calculated
%	yBar: The expected value of yPos 
%	nDof: The number of degree of freedom
%
%
% References can be found in the "Reference" section.
%
% The code is prepared by Zhaohua Wu. For questions, please read the "Q&A" section or
% contact
%   zhwu@cola.iges.org
%
ylen = length(yPos);
eBar = exp(yBar);

evalue=exp(yPos);

for i=1:ylen,
    tmp1 = evalue(i)/eBar-yPos(i);
    tmp2 = -tmp1*nDof*eBar/2;
    tmp3(i) = 0.5*nDof*eBar*log(nDof) + tmp2;
end

rscale = max(tmp3);

tmp4 = tmp3 - rscale;

PDF= exp(tmp4);


