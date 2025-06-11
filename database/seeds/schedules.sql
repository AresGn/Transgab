-- =============================================
-- Horaires fixes du réseau ferroviaire gabonais
-- Départs : Mercredi, Jeudi, Samedi
-- =============================================

-- Horaires Omnibus
INSERT INTO schedules (train_type_id, day_of_week, departure_time, departure_station_id, arrival_station_id, estimated_duration) VALUES

-- Mercredi 13h00 - Omnibus
('omnibus', 'wednesday', '13:00:00', 'OWE', 'FRA', '19:00:00'),

-- Jeudi 13h00 - Omnibus  
('omnibus', 'thursday', '13:00:00', 'OWE', 'FRA', '19:00:00'),

-- Samedi 13h00 - Omnibus
('omnibus', 'saturday', '13:00:00', 'OWE', 'FRA', '19:00:00'),

-- Samedi 20h00 - Omnibus
('omnibus', 'saturday', '20:00:00', 'OWE', 'FRA', '19:00:00');

-- Horaires TSA Express
INSERT INTO schedules (train_type_id, day_of_week, departure_time, departure_station_id, arrival_station_id, estimated_duration) VALUES

-- Mercredi 13h00 - TSA Express
('tsa-express', 'wednesday', '13:00:00', 'OWE', 'FRA', '12:30:00'),

-- Jeudi 13h00 - TSA Express
('tsa-express', 'thursday', '13:00:00', 'OWE', 'FRA', '12:30:00'),

-- Samedi 13h00 - TSA Express
('tsa-express', 'saturday', '13:00:00', 'OWE', 'FRA', '12:30:00'),

-- Samedi 20h00 - TSA Express
('tsa-express', 'saturday', '20:00:00', 'OWE', 'FRA', '12:30:00');

-- =============================================
-- Arrêts détaillés pour Omnibus Mercredi 13h00
-- =============================================

-- Récupérer l'ID du schedule pour Omnibus Mercredi 13h00
DO $$
DECLARE
    schedule_omnibus_wed UUID;
    schedule_omnibus_thu UUID;
    schedule_omnibus_sat_13 UUID;
    schedule_omnibus_sat_20 UUID;
    schedule_express_wed UUID;
    schedule_express_thu UUID;
    schedule_express_sat_13 UUID;
    schedule_express_sat_20 UUID;
BEGIN
    -- Récupérer les IDs des schedules
    SELECT id INTO schedule_omnibus_wed FROM schedules WHERE train_type_id = 'omnibus' AND day_of_week = 'wednesday' AND departure_time = '13:00:00';
    SELECT id INTO schedule_omnibus_thu FROM schedules WHERE train_type_id = 'omnibus' AND day_of_week = 'thursday' AND departure_time = '13:00:00';
    SELECT id INTO schedule_omnibus_sat_13 FROM schedules WHERE train_type_id = 'omnibus' AND day_of_week = 'saturday' AND departure_time = '13:00:00';
    SELECT id INTO schedule_omnibus_sat_20 FROM schedules WHERE train_type_id = 'omnibus' AND day_of_week = 'saturday' AND departure_time = '20:00:00';
    
    SELECT id INTO schedule_express_wed FROM schedules WHERE train_type_id = 'tsa-express' AND day_of_week = 'wednesday' AND departure_time = '13:00:00';
    SELECT id INTO schedule_express_thu FROM schedules WHERE train_type_id = 'tsa-express' AND day_of_week = 'thursday' AND departure_time = '13:00:00';
    SELECT id INTO schedule_express_sat_13 FROM schedules WHERE train_type_id = 'tsa-express' AND day_of_week = 'saturday' AND departure_time = '13:00:00';
    SELECT id INTO schedule_express_sat_20 FROM schedules WHERE train_type_id = 'tsa-express' AND day_of_week = 'saturday' AND departure_time = '20:00:00';

    -- Arrêts Omnibus Mercredi/Jeudi/Samedi 13h00 (mêmes horaires)
    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus) VALUES
    (schedule_omnibus_wed, 'OWE', 1, NULL, '13:00:00', FALSE),
    (schedule_omnibus_wed, 'NTO', 2, '13:25:00', '13:27:00', FALSE),
    (schedule_omnibus_wed, 'AND', 3, '13:45:00', '13:47:00', FALSE),
    (schedule_omnibus_wed, 'MBE', 4, '14:05:00', '14:07:00', FALSE),
    (schedule_omnibus_wed, 'OYA', 5, '14:25:00', '14:27:00', FALSE),
    (schedule_omnibus_wed, 'ABA', 6, '14:50:00', '14:52:00', FALSE),
    (schedule_omnibus_wed, 'NDJ', 7, '17:30:00', '17:45:00', FALSE),
    (schedule_omnibus_wed, 'ALE', 8, '18:15:00', '18:17:00', FALSE),
    (schedule_omnibus_wed, 'OTO', 9, '18:45:00', '18:47:00', FALSE),
    (schedule_omnibus_wed, 'BIS', 10, '19:15:00', '19:17:00', FALSE),
    (schedule_omnibus_wed, 'AYE', 11, '19:45:00', '19:47:00', FALSE),
    (schedule_omnibus_wed, 'LOP', 12, '20:30:00', '20:45:00', FALSE),
    (schedule_omnibus_wed, 'OFF', 13, '21:15:00', '21:17:00', FALSE),
    (schedule_omnibus_wed, 'BOO', 14, '21:45:00', '22:00:00', FALSE),
    (schedule_omnibus_wed, 'IVI', 15, '22:30:00', '22:32:00', FALSE),
    (schedule_omnibus_wed, 'MAY', 16, '23:00:00', '23:02:00', FALSE),
    (schedule_omnibus_wed, 'MIL', 17, '23:30:00', '23:32:00', FALSE),
    (schedule_omnibus_wed, 'LAS', 18, '02:00:00', '02:15:00', FALSE),
    (schedule_omnibus_wed, 'DOU', 19, '02:45:00', '02:47:00', FALSE),
    (schedule_omnibus_wed, 'LIF', 20, '03:15:00', '03:17:00', FALSE),
    (schedule_omnibus_wed, 'MBO', 21, '03:45:00', '03:47:00', FALSE),
    (schedule_omnibus_wed, 'MOA', 22, '05:30:00', '05:45:00', FALSE),
    (schedule_omnibus_wed, 'FRA', 23, '08:00:00', NULL, TRUE);

    -- Copier pour Jeudi et Samedi 13h00 (mêmes horaires)
    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus)
    SELECT schedule_omnibus_thu, station_id, stop_order, arrival_time, departure_time, is_terminus
    FROM schedule_stops WHERE schedule_id = schedule_omnibus_wed;

    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus)
    SELECT schedule_omnibus_sat_13, station_id, stop_order, arrival_time, departure_time, is_terminus
    FROM schedule_stops WHERE schedule_id = schedule_omnibus_wed;

    -- Arrêts Omnibus Samedi 20h00 (horaires décalés)
    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus) VALUES
    (schedule_omnibus_sat_20, 'OWE', 1, NULL, '20:00:00', FALSE),
    (schedule_omnibus_sat_20, 'NTO', 2, '20:25:00', '20:27:00', FALSE),
    (schedule_omnibus_sat_20, 'AND', 3, '20:45:00', '20:47:00', FALSE),
    (schedule_omnibus_sat_20, 'MBE', 4, '21:05:00', '21:07:00', FALSE),
    (schedule_omnibus_sat_20, 'OYA', 5, '21:25:00', '21:27:00', FALSE),
    (schedule_omnibus_sat_20, 'ABA', 6, '21:50:00', '21:52:00', FALSE),
    (schedule_omnibus_sat_20, 'NDJ', 7, '00:30:00', '00:45:00', FALSE),
    (schedule_omnibus_sat_20, 'ALE', 8, '01:15:00', '01:17:00', FALSE),
    (schedule_omnibus_sat_20, 'OTO', 9, '01:45:00', '01:47:00', FALSE),
    (schedule_omnibus_sat_20, 'BIS', 10, '02:15:00', '02:17:00', FALSE),
    (schedule_omnibus_sat_20, 'AYE', 11, '02:45:00', '02:47:00', FALSE),
    (schedule_omnibus_sat_20, 'LOP', 12, '03:30:00', '03:45:00', FALSE),
    (schedule_omnibus_sat_20, 'OFF', 13, '04:15:00', '04:17:00', FALSE),
    (schedule_omnibus_sat_20, 'BOO', 14, '04:45:00', '05:00:00', FALSE),
    (schedule_omnibus_sat_20, 'IVI', 15, '05:30:00', '05:32:00', FALSE),
    (schedule_omnibus_sat_20, 'MAY', 16, '06:00:00', '06:02:00', FALSE),
    (schedule_omnibus_sat_20, 'MIL', 17, '06:30:00', '06:32:00', FALSE),
    (schedule_omnibus_sat_20, 'LAS', 18, '09:00:00', '09:15:00', FALSE),
    (schedule_omnibus_sat_20, 'DOU', 19, '09:45:00', '09:47:00', FALSE),
    (schedule_omnibus_sat_20, 'LIF', 20, '10:15:00', '10:17:00', FALSE),
    (schedule_omnibus_sat_20, 'MBO', 21, '10:45:00', '10:47:00', FALSE),
    (schedule_omnibus_sat_20, 'MOA', 22, '12:30:00', '12:45:00', FALSE),
    (schedule_omnibus_sat_20, 'FRA', 23, '15:00:00', NULL, TRUE);

    -- Arrêts TSA Express (gares principales uniquement)
    -- Mercredi/Jeudi/Samedi 13h00
    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus) VALUES
    (schedule_express_wed, 'OWE', 1, NULL, '13:00:00', FALSE),
    (schedule_express_wed, 'NDJ', 2, '16:30:00', '16:45:00', FALSE),
    (schedule_express_wed, 'LOP', 3, '18:45:00', '19:00:00', FALSE),
    (schedule_express_wed, 'BOO', 4, '20:30:00', '20:45:00', FALSE),
    (schedule_express_wed, 'LAS', 5, '23:15:00', '23:30:00', FALSE),
    (schedule_express_wed, 'MOA', 6, '01:30:00', '01:45:00', FALSE),
    (schedule_express_wed, 'FRA', 7, '02:45:00', NULL, TRUE);

    -- Copier pour Jeudi et Samedi 13h00
    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus)
    SELECT schedule_express_thu, station_id, stop_order, arrival_time, departure_time, is_terminus
    FROM schedule_stops WHERE schedule_id = schedule_express_wed;

    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus)
    SELECT schedule_express_sat_13, station_id, stop_order, arrival_time, departure_time, is_terminus
    FROM schedule_stops WHERE schedule_id = schedule_express_wed;

    -- TSA Express Samedi 20h00
    INSERT INTO schedule_stops (schedule_id, station_id, stop_order, arrival_time, departure_time, is_terminus) VALUES
    (schedule_express_sat_20, 'OWE', 1, NULL, '20:00:00', FALSE),
    (schedule_express_sat_20, 'NDJ', 2, '23:30:00', '23:45:00', FALSE),
    (schedule_express_sat_20, 'LOP', 3, '01:45:00', '02:00:00', FALSE),
    (schedule_express_sat_20, 'BOO', 4, '03:30:00', '03:45:00', FALSE),
    (schedule_express_sat_20, 'LAS', 5, '06:15:00', '06:30:00', FALSE),
    (schedule_express_sat_20, 'MOA', 6, '08:30:00', '08:45:00', FALSE),
    (schedule_express_sat_20, 'FRA', 7, '09:45:00', NULL, TRUE);

END $$;

-- =============================================
-- Tarifs de base (exemples)
-- =============================================

-- Tarifs Omnibus (plus économiques)
INSERT INTO pricing (train_type_id, departure_station_id, arrival_station_id, passenger_type, base_price, currency) VALUES

-- Trajets courts Omnibus
('omnibus', 'OWE', 'NDJ', 'adult', 15000, 'XAF'),
('omnibus', 'OWE', 'NDJ', 'child', 7500, 'XAF'),
('omnibus', 'NDJ', 'LOP', 'adult', 12000, 'XAF'),
('omnibus', 'NDJ', 'LOP', 'child', 6000, 'XAF'),
('omnibus', 'LOP', 'BOO', 'adult', 8000, 'XAF'),
('omnibus', 'LOP', 'BOO', 'child', 4000, 'XAF'),
('omnibus', 'BOO', 'LAS', 'adult', 15000, 'XAF'),
('omnibus', 'BOO', 'LAS', 'child', 7500, 'XAF'),
('omnibus', 'LAS', 'MOA', 'adult', 12000, 'XAF'),
('omnibus', 'LAS', 'MOA', 'child', 6000, 'XAF'),
('omnibus', 'MOA', 'FRA', 'adult', 5000, 'XAF'),
('omnibus', 'MOA', 'FRA', 'child', 2500, 'XAF'),

-- Trajet complet Omnibus
('omnibus', 'OWE', 'FRA', 'adult', 50000, 'XAF'),
('omnibus', 'OWE', 'FRA', 'child', 25000, 'XAF');

-- Tarifs TSA Express (plus chers mais plus rapides)
INSERT INTO pricing (train_type_id, departure_station_id, arrival_station_id, passenger_type, base_price, currency) VALUES

-- Trajets TSA Express
('tsa-express', 'OWE', 'NDJ', 'adult', 25000, 'XAF'),
('tsa-express', 'OWE', 'NDJ', 'child', 12500, 'XAF'),
('tsa-express', 'NDJ', 'LOP', 'adult', 18000, 'XAF'),
('tsa-express', 'NDJ', 'LOP', 'child', 9000, 'XAF'),
('tsa-express', 'LOP', 'BOO', 'adult', 12000, 'XAF'),
('tsa-express', 'LOP', 'BOO', 'child', 6000, 'XAF'),
('tsa-express', 'BOO', 'LAS', 'adult', 20000, 'XAF'),
('tsa-express', 'BOO', 'LAS', 'child', 10000, 'XAF'),
('tsa-express', 'LAS', 'MOA', 'adult', 15000, 'XAF'),
('tsa-express', 'LAS', 'MOA', 'child', 7500, 'XAF'),
('tsa-express', 'MOA', 'FRA', 'adult', 8000, 'XAF'),
('tsa-express', 'MOA', 'FRA', 'child', 4000, 'XAF'),

-- Trajet complet TSA Express
('tsa-express', 'OWE', 'FRA', 'adult', 75000, 'XAF'),
('tsa-express', 'OWE', 'FRA', 'child', 37500, 'XAF');
