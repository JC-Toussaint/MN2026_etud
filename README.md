# Méthodes Numériques et Modélisation en Physique

[![Author](https://img.shields.io/badge/Auteur-Jean--Christophe%20Toussaint-blue.svg)](mailto:jean-christophe.toussaint@grenoble-inp.fr)
[![Institution](https://img.shields.io/badge/Institution-Grenoble--INP%20Phelma-emerald.svg)](https://phelma.grenoble-inp.fr/)
[![Language](https://img.shields.io/badge/Langage-MATLAB-orange.svg)](https://www.mathworks.com/)
[![License](https://img.shields.io/badge/Licence-Phelma%20%2F%20Enseignement-lightgrey.svg)](#)

Ce dépôt rassemble les supports de cours, travaux pratiques (BE) et codes d'application consacrés aux **méthodes d'intégration numérique pour équations différentielles ordinaires (EDO)** et à la **résolution d'équations aux dérivées partielles (EDP)** par la **méthode des différences finies (DF)** et la **méthode des éléments finis (MEF)**.

---

## 👨‍🏫 Auteur & Affiliation

* **Auteur** : Jean-Christophe Toussaint
* **Établissement** : Grenoble-INP / Phelma (École Nationale Supérieure de Physique, Électronique, Matériaux)
* **Domaine** : Physique Numérique, Modélisation et Simulation

---

## 📚 Table des Matières

1. [Vue d'Ensemble du Dépôt](#-vue-densemble-du-dépôt)
2. [Contenu des Modules](#-contenu-des-modules)
   * [1. Intégration Numérique d'Équations Différentielles (EDO)](#1-intégration-numérique-déquations-différentielles-edo)
   * [2. Équation de la Chaleur 1D — Schéma Explicite](#2-équation-de-la-chaleur-1d--schéma-explicite)
   * [3. Équation de la Chaleur 1D — Schéma Implicite & Application aux Ailettes](#3-équation-de-la-chaleur-1d--schéma-implicite--application-aux-ailettes)
   * [4. Intégration Numérique sur Maillage Éléments Finis 1D/2D (Pluviométrie)](#4-intégration-numérique-sur-maillage-éléments-finis-1d2d-pluviométrie)
   * [5. Formulation Éléments Finis (MEF) pour l'Électrocinétique](#5-formulation-éléments-finis-mef-pour-lélectrocinétique)
3. [Structure des Fichiers et Projets](#-structure-des-fichiers-et-projets)
4. [Instructions d'Utilisation (Matlab)](#-instructions-dutilisation-matlab)
5. [Références et Concepts Théoriques Clés](#-références-et-concepts-théoriques-clés)

---

## 🔍 Vue d'Ensemble du Dépôt

Le dépôt est structuré en plusieurs chapitres complémentaires couvrant les aspects théoriques et algorithmiques de la numérisation des problèmes de la physique :
* **Décomposition d'EDO d'ordre $n$** en systèmes du premier ordre explicites.
* **Intégrateurs géométriques explicites à pas fixe et adaptatif** (Euler/RK1, RK2, RK12, RK45 / `ode45`).
* **Résolution d'EDP paraboliques** (Équation de la chaleur) avec étude de la **stabilité de von Neumann** (critères CFL) et traitement des conditions aux limites (**Dirichlet, Neumann, Robin**).
* **Techniques d'intégration numérique sur maillages complexes** (Segments P1, Triangles T3, quadrature de Gauss).
* **Formulation faible de Galerkin et assemblage matriciel** pour des équations elliptiques (Laplacien, Électrocinétique).

---

## 📝 Contenu des Modules

### 1. Intégration Numérique d'Équations Différentielles (EDO)

Ce module traite de la transformation de toute EDO d'ordre $n$ en un système explicite du premier ordre de la forme $\frac{dY}{dt} = f(t, Y(t))$.

* **Modèles d'application** :
  * Oscillateur harmonique amorti : $\frac{d^2x}{dt^2} + \eta \frac{dx}{dt} + \omega_0^2 x = 0$
  * Pendule élastique pesant (système non-linéaire à 2 degrés de liberté sous la contrainte $r > 0$).
* **Schémas d'intégration** :
  * **Euler Explicite (RK1)** : Schéma d'ordre 1, faible coût computationnel, conditionnellement stable ($k < 2/\max_i |\lambda_i|$).
  * **Tangente Améliorée (RK2 / Prédicteur-Correcteur)** : Schéma d'ordre 2 au point milieu $Y_{mid} = Y_n + \frac{k}{2} f(t_n, Y_n)$.
  * **Contrôle adaptatif du pas de temps (RK12)** : Estimation de l'erreur locale $\epsilon = |A_1 - A_2|$ pour réajuster le pas $h' = 0.9 \sqrt{\frac{\epsilon_m}{\epsilon}} h$.
* **Fichiers associés** : `rk1.m`, `oscil.m`, `solver_rk1.m`, `rk_adapt12.m`.

---

### 2. Équation de la Chaleur 1D — Schéma Explicite

Étude de la conduction thermique instationnaire en 1D dans un solide caractérisé par sa conductivité $k_{th}$, sa masse volumique $
ho$ et sa capacité calorifique $c_p$ :
$$\rho c_p \frac{\partial T}{\partial t} - k_{th} \frac{\partial^2 T}{\partial x^2} = Q(x,t)$$

* **Discrétisation spatio-temporelle** :
  * Approximation du Laplacien spatial à l'ordre 2 : $$\frac{\partial^2 T}{\partial x^2}\Big|_p = \frac{T_{p+1} + T_{p-1} - 2T_p}{\Delta x^2} + \mathcal{O}(\Delta x^2)$$
  * Avancement temporel explicite d'ordre 1 : $$T_p^{n+1} = T_p^n + \frac{\Delta t}{ \rho c_p} \left( k_{th} \frac{T_{p+1}^n + T_{p-1}^n - 2T_p^n}{\Delta x^2} + Q_p^n \right)$$
* **Analyse de stabilité de Von Neumann** :
  * Développement en séries de Fourier $\delta T_p = \sum_k \epsilon_k e^{i k p \Delta x}$.
  * Gain numérique $G(k) = 1 - \frac{2 k_{th} \Delta t}{\rho c_p \Delta x^2} (1 - \cos(k \Delta x))$.
  * **Critère de Stabilité Explicite Strict** : $\frac{\Delta t}{\Delta x^2} \le \frac{\rho c_p}{2 k_{th}}$

---

### 3. Équation de la Chaleur 1D — Schéma Implicite & Application aux Ailettes

Pour affranchir la simulation de la contrainte sévère du pas de temps explicite, un schéma implicite est mis en œuvre.

* **Schéma Implicite** :
  $$-\frac{k_{th} \Delta t }{\rho c_p \Delta x^2} T_{p-1}^{n+1} + \left(1 + \frac{2 k_{th} \Delta t }{\rho c_p \Delta x^2} \right) T_p^{n+1} - \frac{k_{th} \Delta t }{\rho c_p \Delta x^2} T_{p+1}^{n+1} = T_p^n + \frac{\Delta t}{\rho c_p} Q_p^{n+1}$$
  * Démonstration d'**inconditionnelle stabilité** ($|G(k)| \le 1, \forall \Delta t, \Delta x$).
  * Résolution via un système tridiagonale / matrice définie positive.
* **Projet d'application : Refroidissement par Ailette de Processeur** :
  * Équation modifiée avec terme de convection surfacique : $-\frac{\partial}{\partial x}\left(k_{th} \frac{\partial T}{\partial x} \right) + \frac{2h}{e}(T - T_a) + \rho c \frac{\partial T}{\partial t} = 0$
  * Validation du modèle par le **Nombre de Biot** ($Bi = \frac{e h}{2 k_{th}} \ll 1$) assurant l'homogénéité en épaisseur.
  * Solution analytique stationnaire de référence : $T(x) = (T_{dg} - T_a) \frac{\cosh(r(x-L))}{\cosh(rL)} + T_a \quad 	avec  \quad r = \sqrt{\frac{2h}{e k_{th}}}$
* **Fichiers associés** : Dossier `ailette_etudiants/`, `implicite.m`.

---

### 4. Intégration Numérique sur Maillage Éléments Finis 1D/2D (Pluviométrie)

Calcul de la hauteur moyenne de précipitation sur un domaine $D$ par intégration d'une grandeur $Q$ interpolée sur un maillage non structuré :
$$I = \iint_D Q(x,y) \, dx \, dy = \sum_{e=1}^{NE} I_e$$

* **Maillage et Transformations Isoparamétriques** :
  * **Éléments 1D (Segments P1 à 2 nœuds)** : Polynômes $L_I(u) = \frac{1-u}{2}, L_{II}(u) = \frac{1+u}{2}$.
  * **Éléments 2D (Triangles T3 à 3 nœuds)** : Fonctions d'interpolation $\alpha_1 = 1-u-v, \alpha_2 = u, \alpha_3 = v$.
* **Quadrature de Gauss** :
  * Calcul exact du jacobien $\det J(u,v)$ de la transformation vers l'élément de référence.
  * Estimation des intégrales élémentaires $I_e = \sum_{k=1}^{NPI} Q_e(u_k, v_k) w_k \det J(u_k, v_k)$.
* **Fichiers associés** : `mesh.pro`, `triangles.pro`, `lecture_probleme.m`, `polynomes_L2.m`, `polynomes_T3.m`, `integrale.m`, `solution.m`, `PRECIPITATION_main.m`.

---

### 5. Formulation Éléments Finis (MEF) pour l'Électrocinétique

Résolution de la forme forte de l'électrocinétique $	div (j) = 0 \implies 	div (-\sigma \nabla V) = 0$.

* **Formulation Faible de Galerkin** :
  $$\int_D \sigma \nabla \beta_i \cdot \nabla V \, d^3r = -\oiint_{\partial D} \beta_i j_n^s \, dS$$
* **Discrétisation et Assemblage Matriciel** :
  * Approximation spatiale $V(r) = \sum_{j} \alpha_j^e(r) V_j$.
  * Matrice de raideur élémentaire : $A_{ie, je}^e = \sum_{k=1}^{NPI} \sigma 
\nabla \alpha_{ie}^e(k) \cdot 
\nabla \alpha_{je}^e(k) \, w_k \det J_k$
  * Vecteur second membre élémentaire (conditions de Neumann) : $B_{ie}^e = -\sum_{k=1}^{NPI} \alpha_{ie}^e(k) j_n^s w_k \det J_k$
  * Assemblage global $A V = B$ en utilisant la table de connectivité du maillage.
* **Prise en compte des Conditions aux Limites** :
  * **Neumann** (flux de courant imposé $j_n^s$) : Intégré directement dans le second membre volumique/surfacique.
  * **Dirichlet** (potentiel imposé $V_i = V_i^0$) : Imposition nodale directe sur la matrice globale.

---

## 📁 Structure des Fichiers et Projets

```text
.
├── 01_EDO/
│   ├── rk1.m                      # Solveur Euler explicite (RK1)
│   ├── rk_adapt12.m               # Solveur RK12 à pas adaptatif
│   ├── oscil.m                    # Définition du système dynamique (oscillateur)
│   └── solver_rk1.m               # Script principal de démonstration EDO
├── 02_DF_Explicite/
│   └── cours_DF_explicite.pdf     # Support théorique et schémas explicites
├── 03_DF_Implicite_Ailette/
│   ├── ailette_etudiants/
│   │   ├── implicite.m            # Résolution implicite du problème d'ailette
│   │   └── main_ailette.m         # Execution et comparaison analytique
├── 04_Integ_EF_Pluviometrie/
│   ├── 1D/
│   │   ├── mesh.pro               # Coordonnées, connectivité et mesures 1D
│   │   ├── polynomes_L2.m         # Interpolation et Gauss sur segment
│   │   └── PRECIPITATION_main.m   # Script principal 1D
│   └── 2D/
│       ├── triangles.pro          # Maillage surfacique triangulaire
│       ├── polynomes_T3.m         # Interpolation et Jacobien sur triangle
│       └── PRECIPITATION_main.m   # Script principal 2D
└── 05_MEF_Electrocinetique/
    └── cours_MEF_electrocin.pdf   # Formulations faible de Galerkin et assemblage
```

---


## 📖 Références et Concepts Théoriques Clés

1. **William H. Press, Saul A. Teukolsky, William T. Vetterling, Brian P. Flannery**  
   *"Numerical Recipes 3rd Edition: The Art of Scientific Computing"*, Cambridge University Press (ISBN-10: 0521880688, or ISBN-13: 978-0521880688).

2. **Jean-Philippe Grivet**  
   *"Méthodes Numériques Appliquées pour le scientifique et l'ingénieur"*, Grenoble Sciences (ISBN-13: 978-2759803866).

3. **Gouri Dhatt, Gilbert Touzot, Emmanuel Lefrançois**  
   *« Méthode des éléments finis »*, Hermès-Lavoisier (ISBN-10: 2746209799, ou ISBN-13: 978-2746209794).

4. **Patrick Lascaux, Raymond Théodor**  
   *« Analyse numérique matricielle appliquée à l'art de l'ingénieur, tome 1: Méthodes directes, tome 2: Méthodes itératives »*, Dunod (ISBN-10: 2100484281).

5. **B. Lucquin et O. Pironneau**  
   *« Introduction au calcul scientifique »*, Masson, 1996.

6. **D. Euvrard**  
   *« Résolution numérique des équations aux dérivées partielles »*, Masson (ISBN-10: 2225845093).

7. **Jonathan Richard Shewchuk**  
   *"An Introduction to the Conjugate Gradient Method Without the Agonizing Pain"*, [http://www.cs.cmu.edu/~jrs/jrspapers.html](http://www.cs.cmu.edu/~jrs/jrspapers.html)

8. **Fred Vermolen**  
   *"Introduction into Finite Elements"*, [http://ta.twi.tudelft.nl/users/vermolen/wi3098/wi3098.pdf](http://ta.twi.tudelft.nl/users/vermolen/wi3098/wi3098.pdf)

---
*Enseignement dispensé à Grenoble-INP Phelma par Jean-Christophe Toussaint.*
