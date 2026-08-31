function [ u ] = u_ana( fem, r)

R=fem.xmax;

eta=fem.equ.eta(1);
rho=fem.equ.rho(1);
fz0=fem.equ.fz0(1);
freq=fem.equ.freq(1);

nu=eta/rho;
omega=2*pi*freq;

%%% DEBUT DU BLOC A RECOPIER DANS VOTRE COPIE %%%    
K=sqrt(1i*omega/nu);
u=0; % A COMPLETER;

%%% FIN DU BLOC A RECOPIER DANS VOTRE COPIE %%%

end

