-- =============================================
-- Script de déploiement complet pour Neon PostgreSQL
-- Train Reservation Gabon - Base de données cloud
-- =============================================

-- =============================================
-- 1. CRÉATION DU SCHÉMA COMPLET
-- =============================================

-- Extension pour UUID (généralement déjà disponible sur Neon)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- Table des utilisateurs
-- =============================================
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'other')),
    nationality VARCHAR(50) DEFAULT 'Gabonaise',
    id_number VARCHAR(50),
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des gares
-- =============================================
CREATE TABLE IF NOT EXISTS stations (
    id VARCHAR(3) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('principal', 'secondaire')),
    province VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    facilities TEXT[],
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des types de trains
-- =============================================
CREATE TABLE IF NOT EXISTS train_types (
    id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INTEGER NOT NULL,
    features TEXT[],
    services TEXT[],
    color VARCHAR(7),
    icon VARCHAR(10),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des horaires fixes
-- =============================================
CREATE TABLE IF NOT EXISTS schedules (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    train_type_id VARCHAR(20) REFERENCES train_types(id),
    day_of_week VARCHAR(10) NOT NULL CHECK (day_of_week IN ('wednesday', 'thursday', 'saturday')),
    departure_time TIME NOT NULL,
    departure_station_id VARCHAR(3) REFERENCES stations(id),
    arrival_station_id VARCHAR(3) REFERENCES stations(id),
    estimated_duration INTERVAL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des arrêts par horaire
-- =============================================
CREATE TABLE IF NOT EXISTS schedule_stops (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    schedule_id UUID REFERENCES schedules(id) ON DELETE CASCADE,
    station_id VARCHAR(3) REFERENCES stations(id),
    stop_order INTEGER NOT NULL,
    arrival_time TIME,
    departure_time TIME,
    stop_duration INTERVAL DEFAULT '2 minutes',
    is_terminus BOOLEAN DEFAULT FALSE
);

-- =============================================
-- Table des réservations
-- =============================================
CREATE TABLE IF NOT EXISTS bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    schedule_id UUID REFERENCES schedules(id),
    departure_station_id VARCHAR(3) REFERENCES stations(id),
    arrival_station_id VARCHAR(3) REFERENCES stations(id),
    travel_date DATE NOT NULL,
    passenger_count INTEGER NOT NULL DEFAULT 1,
    total_amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'XAF',
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed')),
    booking_reference VARCHAR(20) UNIQUE NOT NULL,
    special_requests TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des passagers
-- =============================================
CREATE TABLE IF NOT EXISTS passengers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'other')),
    id_number VARCHAR(50),
    seat_number VARCHAR(10),
    passenger_type VARCHAR(20) DEFAULT 'adult' CHECK (passenger_type IN ('adult', 'child', 'infant')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des paiements
-- =============================================
CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES bookings(id),
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'XAF',
    payment_method VARCHAR(50) NOT NULL,
    payment_provider VARCHAR(50),
    transaction_id VARCHAR(100) UNIQUE,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'failed', 'refunded')),
    payment_date TIMESTAMP WITH TIME ZONE,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des tarifs
-- =============================================
CREATE TABLE IF NOT EXISTS pricing (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    train_type_id VARCHAR(20) REFERENCES train_types(id),
    departure_station_id VARCHAR(3) REFERENCES stations(id),
    arrival_station_id VARCHAR(3) REFERENCES stations(id),
    passenger_type VARCHAR(20) DEFAULT 'adult',
    base_price DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'XAF',
    is_active BOOLEAN DEFAULT TRUE,
    effective_from DATE DEFAULT CURRENT_DATE,
    effective_until DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- INDEX POUR OPTIMISER LES PERFORMANCES
-- =============================================

-- Index sur les utilisateurs
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);

-- Index sur les gares
CREATE INDEX IF NOT EXISTS idx_stations_type ON stations(type);
CREATE INDEX IF NOT EXISTS idx_stations_province ON stations(province);

-- Index sur les horaires
CREATE INDEX IF NOT EXISTS idx_schedules_train_type ON schedules(train_type_id);
CREATE INDEX IF NOT EXISTS idx_schedules_day_departure ON schedules(day_of_week, departure_time);
CREATE INDEX IF NOT EXISTS idx_schedules_stations ON schedules(departure_station_id, arrival_station_id);

-- Index sur les arrêts
CREATE INDEX IF NOT EXISTS idx_schedule_stops_schedule ON schedule_stops(schedule_id);
CREATE INDEX IF NOT EXISTS idx_schedule_stops_station ON schedule_stops(station_id);
CREATE INDEX IF NOT EXISTS idx_schedule_stops_order ON schedule_stops(schedule_id, stop_order);

-- Index sur les réservations
CREATE INDEX IF NOT EXISTS idx_bookings_user ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_schedule ON bookings(schedule_id);
CREATE INDEX IF NOT EXISTS idx_bookings_travel_date ON bookings(travel_date);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);
CREATE INDEX IF NOT EXISTS idx_bookings_reference ON bookings(booking_reference);
CREATE INDEX IF NOT EXISTS idx_bookings_stations ON bookings(departure_station_id, arrival_station_id);

-- Index sur les passagers
CREATE INDEX IF NOT EXISTS idx_passengers_booking ON passengers(booking_id);

-- Index sur les paiements
CREATE INDEX IF NOT EXISTS idx_payments_booking ON payments(booking_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_transaction ON payments(transaction_id);
CREATE INDEX IF NOT EXISTS idx_payments_date ON payments(payment_date);

-- Index sur les tarifs
CREATE INDEX IF NOT EXISTS idx_pricing_train_type ON pricing(train_type_id);
CREATE INDEX IF NOT EXISTS idx_pricing_route ON pricing(departure_station_id, arrival_station_id);
CREATE INDEX IF NOT EXISTS idx_pricing_active ON pricing(is_active);

-- =============================================
-- TRIGGERS POUR UPDATED_AT
-- =============================================

-- Fonction pour mettre à jour updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_bookings_updated_at ON bookings;
CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON bookings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_payments_updated_at ON payments;
CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON payments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =============================================
-- 2. INSERTION DES DONNÉES DE BASE
-- =============================================

-- =============================================
-- Insertion des 22 gares gabonaises
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
 'Terminus nord du Transgabonais, capitale économique du Haut-Ogooué')

ON CONFLICT (id) DO NOTHING;

-- =============================================
-- Insertion des types de trains
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
 '#ef4444', '🚅')

ON CONFLICT (id) DO NOTHING;

-- =============================================
-- Insertion des horaires
-- =============================================
INSERT INTO schedules (train_type_id, day_of_week, departure_time, departure_station_id, arrival_station_id, estimated_duration) VALUES

-- Horaires Omnibus
('omnibus', 'wednesday', '13:00:00', 'OWE', 'FRA', '19:00:00'),
('omnibus', 'thursday', '13:00:00', 'OWE', 'FRA', '19:00:00'),
('omnibus', 'saturday', '13:00:00', 'OWE', 'FRA', '19:00:00'),
('omnibus', 'saturday', '20:00:00', 'OWE', 'FRA', '19:00:00'),

-- Horaires TSA Express
('tsa-express', 'wednesday', '13:00:00', 'OWE', 'FRA', '12:30:00'),
('tsa-express', 'thursday', '13:00:00', 'OWE', 'FRA', '12:30:00'),
('tsa-express', 'saturday', '13:00:00', 'OWE', 'FRA', '12:30:00'),
('tsa-express', 'saturday', '20:00:00', 'OWE', 'FRA', '12:30:00');

-- =============================================
-- Insertion des tarifs de base
-- =============================================
INSERT INTO pricing (train_type_id, departure_station_id, arrival_station_id, passenger_type, base_price, currency) VALUES

-- Tarifs Omnibus
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
('omnibus', 'OWE', 'FRA', 'adult', 50000, 'XAF'),
('omnibus', 'OWE', 'FRA', 'child', 25000, 'XAF'),

-- Tarifs TSA Express
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
('tsa-express', 'OWE', 'FRA', 'adult', 75000, 'XAF'),
('tsa-express', 'OWE', 'FRA', 'child', 37500, 'XAF');

-- =============================================
-- 3. VÉRIFICATIONS ET STATISTIQUES
-- =============================================

-- Afficher les statistiques de déploiement
SELECT 'Gares créées' as type, COUNT(*) as count FROM stations
UNION ALL
SELECT 'Types de trains' as type, COUNT(*) as count FROM train_types
UNION ALL
SELECT 'Horaires configurés' as type, COUNT(*) as count FROM schedules
UNION ALL
SELECT 'Tarifs configurés' as type, COUNT(*) as count FROM pricing;
