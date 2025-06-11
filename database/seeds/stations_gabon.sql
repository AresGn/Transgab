-- =============================================
-- Données des 22 gares du réseau ferroviaire gabonais
-- Transgabonais - Owendo à Franceville
-- =============================================

INSERT INTO stations (id, name, full_name, type, province, latitude, longitude, facilities, description) VALUES

-- Province de l'Estuaire
('OWE', 'Owendo', 'Owendo', 'principal', 'Estuaire', 0.3167, 9.5000, 
 ARRAY['parking', 'restaurant', 'waiting-room', 'ticket-office', 'restrooms', 'security'], 
 'Gare principale et terminus sud du Transgabonais, située près de Libreville'),

('NTO', 'N''toum', 'N''toum', 'secondaire', 'Estuaire', 0.3833, 9.7667, 
 ARRAY['waiting-room', 'ticket-office', 'restrooms'], 
 'Gare secondaire dans la province de l''Estuaire'),

('AND', 'Andeme', 'Andeme', 'secondaire', 'Estuaire', 0.4500, 9.9000, 
 ARRAY['waiting-room', 'restrooms'], 
 'Petite gare de la province de l''Estuaire'),

('MBE', 'M''Bel', 'M''Bel', 'secondaire', 'Estuaire', 0.5167, 10.0333, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare secondaire de la province de l''Estuaire'),

('OYA', 'Oyan', 'Oyan', 'secondaire', 'Moyen-Ogooué', 0.5833, 10.1667, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare de transition vers le Moyen-Ogooué'),

('ABA', 'Abanga', 'Abanga', 'secondaire', 'Moyen-Ogooué', 0.6500, 10.3000, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare du Moyen-Ogooué'),

-- Province du Moyen-Ogooué
('NDJ', 'Ndjolé', 'Ndjolé', 'principal', 'Moyen-Ogooué', -0.1833, 10.7667, 
 ARRAY['parking', 'restaurant', 'waiting-room', 'ticket-office', 'hotel', 'restrooms', 'security'], 
 'Gare principale du Moyen-Ogooué, important centre de correspondance'),

('ALE', 'Alembé', 'Alembé', 'secondaire', 'Moyen-Ogooué', -0.2500, 11.0000, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare secondaire du Moyen-Ogooué'),

-- Province de l'Ogooué-Ivindo
('OTO', 'Otoumbi', 'Otoumbi', 'secondaire', 'Ogooué-Ivindo', -0.3167, 11.2333, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare de l''Ogooué-Ivindo'),

('BIS', 'Bissouna', 'Bissouna', 'secondaire', 'Ogooué-Ivindo', -0.3833, 11.4667, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare secondaire de l''Ogooué-Ivindo'),

('AYE', 'Ayem', 'Ayem', 'secondaire', 'Ogooué-Ivindo', -0.4500, 11.7000, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare de l''Ogooué-Ivindo'),

('LOP', 'Lopé', 'Lopé', 'principal', 'Ogooué-Ivindo', -0.2000, 11.5833, 
 ARRAY['parking', 'restaurant', 'waiting-room', 'ticket-office', 'restrooms', 'security'], 
 'Gare principale près du Parc National de Lopé'),

('OFF', 'Offoué', 'Offoué', 'secondaire', 'Ogooué-Ivindo', -0.1167, 11.8000, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare secondaire de l''Ogooué-Ivindo'),

('BOO', 'Booué', 'Booué', 'principal', 'Ogooué-Ivindo', -0.0833, 11.9333, 
 ARRAY['parking', 'restaurant', 'waiting-room', 'ticket-office', 'restrooms', 'security'], 
 'Gare principale de l''Ogooué-Ivindo'),

('IVI', 'Ivindo', 'Ivindo', 'secondaire', 'Ogooué-Ivindo', 0.0000, 12.1667, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare près de la rivière Ivindo'),

-- Province de l'Ogooué-Lolo
('MAY', 'Mayabi', 'Mayabi', 'secondaire', 'Ogooué-Lolo', 0.0833, 12.4000, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare de transition vers l''Ogooué-Lolo'),

('MIL', 'Milolé', 'Milolé', 'secondaire', 'Ogooué-Lolo', 0.1500, 12.6333, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare de l''Ogooué-Lolo'),

('LAS', 'Lastourville', 'Lastourville', 'principal', 'Ogooué-Lolo', -0.8167, 12.7000, 
 ARRAY['parking', 'restaurant', 'waiting-room', 'ticket-office', 'restrooms', 'security'], 
 'Gare principale de l''Ogooué-Lolo'),

-- Province du Haut-Ogooué
('DOU', 'Doumé', 'Doumé', 'secondaire', 'Haut-Ogooué', -0.9000, 12.9333, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare d''entrée dans le Haut-Ogooué'),

('LIF', 'Lifouta', 'Lifouta', 'secondaire', 'Haut-Ogooué', -0.9667, 13.1667, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare du Haut-Ogooué'),

('MBO', 'Mboungou-Mbadouma', 'Mboungou-Mbadouma', 'secondaire', 'Haut-Ogooué', -1.0333, 13.4000, 
 ARRAY['waiting-room', 'restrooms'], 
 'Gare du Haut-Ogooué'),

('MOA', 'Moanda', 'Moanda', 'principal', 'Haut-Ogooué', -1.5333, 13.2000, 
 ARRAY['parking', 'restaurant', 'waiting-room', 'ticket-office', 'restrooms', 'security'], 
 'Gare principale de Moanda, centre minier important'),

('FRA', 'Franceville', 'Franceville', 'principal', 'Haut-Ogooué', -1.6333, 13.5833, 
 ARRAY['parking', 'restaurant', 'waiting-room', 'ticket-office', 'hotel', 'restrooms', 'security'], 
 'Terminus nord du Transgabonais, capitale économique du Haut-Ogooué');

-- =============================================
-- Vérification des données insérées
-- =============================================

-- Compter le nombre total de gares
-- SELECT COUNT(*) as total_stations FROM stations;

-- Compter par type
-- SELECT type, COUNT(*) as count FROM stations GROUP BY type;

-- Compter par province
-- SELECT province, COUNT(*) as count FROM stations GROUP BY province ORDER BY province;
