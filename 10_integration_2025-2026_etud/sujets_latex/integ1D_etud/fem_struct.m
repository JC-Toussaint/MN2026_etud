fem.NP	: nombre de noeuds

Pour np dans [1, fem.NP]
	fem.noeud(np).x abscisse du noeuds np 
	fem.sol(np)	valeur de la grandeur au noeud np

----------------------------------------------------------

fem.NE	: nombre d'elements

Pour ne dans [1, fem.NE]
 
fem.elt(ne).TYP     : dimension de l'element 
fem.elt(ne).NBN	    : nombre de noeuds de l'element
fem.elt(ne).NRG     : numero de region auquelle appartient l'element
fem.elt(ne).ind(ie) : liste des numeros de noeuds de l'element

