function resultats_inter(nbr_elem,resultat_elem,surface_elem)

% Impression du resultat dans une boite de dialogue
   for m = 1:nbr_elem % boucle sur tous les elements
       legende_1=strcat('Precipitation (cm km) element n ',num2str(m));
       prompt(m) = {legende_1};
       def(m)={num2str(resultat_elem(m))};
   end
num_lines=1;
dlg_title = 'RESULTATS INTERMEDIAIRES PRECIPITATION';
valeur  = inputdlg(prompt,dlg_title,num_lines,def,'on');

% Impression du resultat dans une boite de dialogue
   for m = 1:nbr_elem % boucle sur tous les elements
       legende_2=strcat('Surface (km) element n ',num2str(m));
       prompt(m) = {legende_2};
       def(m)={num2str(surface_elem(m))};
   end
num_lines=1;
dlg_title = 'RESULTATS INTERMEDIAIRES SURFACES';
valeur  = inputdlg(prompt,dlg_title,num_lines,def,'on');