
clear all
close all

% Recherche du dossier de sortie à partir de l'emplacement
% de Control_Argo_chain_vio.m

rootFolder = fileparts(mfilename('fullpath'));

ncFolder = fullfile(rootFolder, ...
    'decArgo_demo', 'output', 'nc');

if ~exist(ncFolder, 'dir')
    error('Dossier de sortie introuvable : %s', ncFolder);
end

fprintf('Dossier NetCDF utilisé : %s\n\n', ncFolder);

% Recherche automatique des dossiers WMO

floatFolders = dir(ncFolder);
floatFolders = floatFolders([floatFolders.isdir]);
floatFolders = floatFolders(~ismember({floatFolders.name}, {'.','..'}));

for iFloat = 1:length(floatFolders)

    wmo = floatFolders(iFloat).name;

    folder = fullfile(ncFolder, wmo, 'profiles');

    if ~exist(folder, 'dir')
        continue
    end

    files = dir(fullfile(folder, 'R*.nc'));

    if isempty(files)
        fprintf('Aucun profil R*.nc pour le flotteur %s\n', wmo);
        continue
    end

    fprintf('Tracé des profils du flotteur %s (%d fichiers)\n', wmo, length(files));

    figure;
    set(gcf, 'Color', 'w');

    subplot(1,2,1);
    hold on;
    grid on;
    box on;
    title('Profils de température CTD');
    xlabel('Température (°C)');
    ylabel('Pression (dbar)');
    set(gca,'YDir','reverse');

    subplot(1,2,2);
    hold on;
    grid on;
    box on;
    title('Profils de salinité CTD');
    xlabel('Salinité');
    ylabel('Pression (dbar)');
    set(gca,'YDir','reverse');

    for k = 1:length(files)

        f = fullfile(folder, files(k).name);

        try
            P = double(ncread(f,'PRES'));
            T = double(ncread(f,'TEMP'));
            S = double(ncread(f,'PSAL'));

            % Valeurs manquantes
            P(P == 99999) = NaN;
            T(T == 99999) = NaN;
            S(S == 99999) = NaN;

            % Tracé des profils
            subplot(1,2,1);
            plot(T,P,'r');

            subplot(1,2,2);
            plot(S,P,'b');

        catch
            fprintf('Fichier ignoré : %s\n', files(k).name);
        end
    end

    sgtitle(['Flotteur ' wmo ' - Ensemble des profils CTD']);

end
