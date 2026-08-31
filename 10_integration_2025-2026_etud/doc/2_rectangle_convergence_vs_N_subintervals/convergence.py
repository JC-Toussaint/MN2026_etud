import numpy as np
import matplotlib.pyplot as plt

def integrale_rectangles(N):
    """Calcule l'intégrale de 1/(1+x²) sur [0,2] par méthode des rectangles"""
    dx = 2.0 / N
    # Points milieux sur [0,2]
    x = np.linspace(dx/2, 2 - dx/2, N)
    return dx * np.sum(1 / (1 + x**2))

def integration_numerique():
    """Fonction principale d'analyse de convergence"""
    
    # Valeur exacte: ∫₀² 1/(1+x²) dx = [arctan(x)]₀² = arctan(2)
    valeur_exacte = np.arctan(2)
    
    # Génération intelligente des valeurs de N
    N_min, N_max = 10, 5000
    N_values = np.unique(np.logspace(np.log10(N_min), np.log10(N_max), 20).astype(int))
    
    erreurs = []
    resultats = []
    
    print(f"Intégrale: ∫₀² 1/(1+x²) dx")
    print(f"Valeur exacte: arctan(2) = {valeur_exacte:.10f}")
    print("-" * 60)
    
    # Calcul pour chaque N
    for N in N_values:
        resultat = integrale_rectangles(N)
        erreur = abs(resultat - valeur_exacte)
        
        resultats.append(resultat)
        erreurs.append(erreur)
        
        print(f"N = {N:4d} | Résultat = {resultat:.8f} | Erreur = {erreur:.2e}")
    
    # Conversion en arrays numpy
    erreurs = np.array(erreurs)
    resultats = np.array(resultats)
    
    # Étude de la convergence - recherche de la loi de puissance
    log_N = np.log(N_values)
    log_erreurs = np.log(erreurs)
    coeff = np.polyfit(log_N, log_erreurs, 1)
    exposant = coeff[0]
    
    print(f"\nLoi de puissance trouvée: erreur ∝ N^({exposant:.3f})")
    print(f"Théoriquement, on attend erreur ∝ N^(-2) pour les rectangles")
    
    # Visualisation
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
    
    # Graphique 1: Convergence
    ax1.loglog(N_values, erreurs, 'bo-', linewidth=2, markersize=6, label='Erreur observée')
    ax1.loglog(N_values, np.exp(coeff[1]) * N_values**exposant, 'r--', 
               linewidth=2, label=f'Ajustement: N^{exposant:.2f}')
    ax1.loglog(N_values, 0.01 / N_values**2, 'g:', 
               linewidth=2, label='Référence: N^(-2)')
    ax1.set_xlabel('Nombre de subdivisions N')
    ax1.set_ylabel('Erreur absolue')
    ax1.set_title('Convergence de la méthode des rectangles')
    ax1.legend()
    ax1.grid(True)
    
    # Graphique 2: Valeurs calculées vs exacte
    ax2.semilogx(N_values, resultats, 'bo-', linewidth=2, markersize=6, 
                 label='Valeurs calculées')
    ax2.axhline(y=valeur_exacte, color='r', linestyle='--', linewidth=2, 
                label='Valeur exacte')
    ax2.set_xlabel('Nombre de subdivisions N')
    ax2.set_ylabel('Valeur de l\'intégrale')
    ax2.set_title(f'Convergence vers arctan(2) = {valeur_exacte:.6f}')
    ax2.legend()
    ax2.grid(True)
    
    plt.tight_layout()
    plt.show()
    
    # Vérification empirique de la convergence
    print(f"\nVérification empirique:")
    for i in range(1, len(N_values)-1):
        if erreurs[i] > 0:  # Éviter division par zéro
            ratio = erreurs[i-1] / erreurs[i]
            ratio_N = N_values[i] / N_values[i-1]
            print(f"N: {N_values[i-1]} → {N_values[i]} | "
                  f"Ratio erreurs: {ratio:.2f} | "
                  f"Ratio N²: {ratio_N**2:.2f}")
    
    return N_values, erreurs

if __name__ == "__main__":
    # Appel de la fonction principale
    N_values, erreurs = integration_numerique()