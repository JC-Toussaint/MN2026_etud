clc
clear all
close all

% Appel de la fonction principale
[N_values, erreurs] = integration_numerique();

function [N_values, erreurs] = integration_numerique()
    % Calcul numérique de l'intégrale de 1/(1+x²) sur [0,2]
    % Méthode des rectangles avec étude de convergence
    
    % Valeur exacte: ∫₀² 1/(1+x²) dx = [arctan(x)]₀² = arctan(2) - arctan(0)
    valeur_exacte = atan(2);
    
    % Génération intelligente des valeurs de N (plus large gamme)
    N_min = 10; N_max = 5000;
    N_values = unique(round(logspace(log10(N_min), log10(N_max), 20)));
    
    erreurs = zeros(size(N_values));
    resultats = zeros(size(N_values));
    
    fprintf('Intégrale: ∫₀² 1/(1+x²) dx\n');
    fprintf('Valeur exacte: arctan(2) = %.10f\n', valeur_exacte);
    fprintf(repmat('-', 1, 60)); fprintf('\n');
    
    % Calcul pour chaque N
    for i = 1:length(N_values)
        N = N_values(i);
        resultat = integrale_rectangles(N);
        erreur = abs(resultat - valeur_exacte);
        
        resultats(i) = resultat;
        erreurs(i) = erreur;
        
        fprintf('N = %4d | Résultat = %.8f | Erreur = %.2e\n', ...
                N, resultat, erreur);
    end
    
    % Étude de la convergence - loi de puissance
    log_N = log(N_values);
    log_erreurs = log(erreurs);
    coeff = polyfit(log_N, log_erreurs, 1);
    exposant = coeff(1);
    
    fprintf('\nLoi de puissance trouvée: erreur ∝ N^(%.3f)\n', exposant);
    fprintf('Théoriquement, on attend erreur ∝ N^(-2) pour les rectangles\n');
    
    % Visualisation
    figure('Position', [100, 100, 1200, 500]);
    
    % Graphique 1: Convergence
    subplot(1, 2, 1);
    loglog(N_values, erreurs, 'bo-', 'LineWidth', 2, 'MarkerSize', 6);
    hold on;
    loglog(N_values, exp(coeff(2)) * N_values.^exposant, 'r--', 'LineWidth', 2);
    loglog(N_values, 0.01 * N_values.^(-2), 'g:', 'LineWidth', 2);
    xlabel('Nombre de subdivisions N');
    ylabel('Erreur absolue');
    title('Convergence de la méthode des rectangles');
    legend('Erreur observée', sprintf('Ajustement: N^{%.2f}', exposant), ...
           'Référence: N^{-2}', 'Location', 'best');
    grid on;
    
    % Graphique 2: Valeurs calculées vs exacte
    subplot(1, 2, 2);
    semilogx(N_values, resultats, 'bo-', 'LineWidth', 2, 'MarkerSize', 6);
    hold on;
    semilogx([N_values(1), N_values(end)], [valeur_exacte, valeur_exacte], ...
             'r--', 'LineWidth', 2);
    xlabel('Nombre de subdivisions N');
    ylabel('Valeur de l''intégrale');
    title(sprintf('Convergence vers arctan(2) = %.6f', valeur_exacte));
    legend('Valeurs calculées', 'Valeur exacte', 'Location', 'best');
    grid on;
    
    % Vérification empirique de la convergence
    fprintf('\nVérification empirique:\n');
    for i = 2:(length(N_values)-1)
        if erreurs(i) > 0  % Éviter division par zéro
            ratio = erreurs(i-1) / erreurs(i);
            ratio_N = N_values(i) / N_values(i-1);
            fprintf('N: %d → %d | Ratio erreurs: %.2f | Ratio N²: %.2f\n', ...
                    N_values(i-1), N_values(i), ratio, ratio_N^2);
        end
    end
end

function resultat = integrale_rectangles(N)
    % Calcule l'intégrale de 1/(1+x²) sur [0,2] par méthode des rectangles
    % Utilise les points milieux des rectangles
    
    dx = 2.0 / N;
    % CORRECTION: intervalle [0,2] donc points milieux de 0+dx/2 à 2-dx/2
    x = linspace(dx/2, 2 - dx/2, N);  % Points milieux sur [0,2]
    resultat = dx * sum(1 ./ (1 + x.^2));
end