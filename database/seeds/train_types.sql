-- =============================================
-- Types de trains du réseau ferroviaire gabonais
-- Omnibus et TSA Express
-- =============================================

INSERT INTO train_types (id, name, display_name, description, capacity, features, services, color, icon) VALUES

-- Train Omnibus
('omnibus', 'Omnibus', 'Train Omnibus', 
 'Train desservant toutes les gares du réseau gabonais (22 arrêts)', 
 200, 
 ARRAY[
   'Dessert les 22 gares du réseau',
   'Transport local et régional',
   'Arrêts fréquents',
   'Tarifs économiques',
   'Idéal pour découvrir le pays'
 ],
 ARRAY[
   'Sièges standards',
   'Bagages autorisés',
   'Vente à bord',
   'Climatisation',
   'Toilettes',
   'Éclairage'
 ],
 '#64748b', '🚂'),

-- TSA Express
('tsa-express', 'TSA Express', 'TSA Express', 
 'Train express desservant uniquement les gares principales (7 arrêts)', 
 150, 
 ARRAY[
   'Dessert 7 gares principales uniquement',
   'Transport rapide inter-villes',
   'Arrêts limités',
   'Gain de temps considérable',
   'Service premium'
 ],
 ARRAY[
   'Sièges confort',
   'Bagages autorisés',
   'Service de restauration',
   'Climatisation renforcée',
   'Wi-Fi (selon disponibilité)',
   'Toilettes premium',
   'Prises électriques'
 ],
 '#ef4444', '🚅');

-- =============================================
-- Vérification des données insérées
-- =============================================

-- SELECT * FROM train_types;
