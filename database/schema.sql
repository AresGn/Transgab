-- =============================================
-- Schéma de base de données - Train Reservation Gabon
-- PostgreSQL Database Schema
-- =============================================

-- Extension pour UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- Table des utilisateurs
-- =============================================
CREATE TABLE users (
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
CREATE TABLE stations (
    id VARCHAR(3) PRIMARY KEY, -- Code à 3 lettres (OWE, NDJ, etc.)
    name VARCHAR(100) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('principal', 'secondaire')),
    province VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    facilities TEXT[], -- Array des équipements disponibles
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des types de trains
-- =============================================
CREATE TABLE train_types (
    id VARCHAR(20) PRIMARY KEY, -- 'omnibus' ou 'tsa-express'
    name VARCHAR(50) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INTEGER NOT NULL,
    features TEXT[], -- Array des caractéristiques
    services TEXT[], -- Array des services
    color VARCHAR(7), -- Code couleur hex
    icon VARCHAR(10),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Table des horaires fixes
-- =============================================
CREATE TABLE schedules (
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
CREATE TABLE schedule_stops (
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
CREATE TABLE bookings (
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
CREATE TABLE passengers (
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
CREATE TABLE payments (
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
CREATE TABLE pricing (
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
-- Index pour optimiser les performances
-- =============================================

-- Index sur les utilisateurs
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Index sur les gares
CREATE INDEX idx_stations_type ON stations(type);
CREATE INDEX idx_stations_province ON stations(province);

-- Index sur les horaires
CREATE INDEX idx_schedules_train_type ON schedules(train_type_id);
CREATE INDEX idx_schedules_day_departure ON schedules(day_of_week, departure_time);
CREATE INDEX idx_schedules_stations ON schedules(departure_station_id, arrival_station_id);

-- Index sur les arrêts
CREATE INDEX idx_schedule_stops_schedule ON schedule_stops(schedule_id);
CREATE INDEX idx_schedule_stops_station ON schedule_stops(station_id);
CREATE INDEX idx_schedule_stops_order ON schedule_stops(schedule_id, stop_order);

-- Index sur les réservations
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_schedule ON bookings(schedule_id);
CREATE INDEX idx_bookings_travel_date ON bookings(travel_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_reference ON bookings(booking_reference);
CREATE INDEX idx_bookings_stations ON bookings(departure_station_id, arrival_station_id);

-- Index sur les passagers
CREATE INDEX idx_passengers_booking ON passengers(booking_id);

-- Index sur les paiements
CREATE INDEX idx_payments_booking ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_transaction ON payments(transaction_id);
CREATE INDEX idx_payments_date ON payments(payment_date);

-- Index sur les tarifs
CREATE INDEX idx_pricing_train_type ON pricing(train_type_id);
CREATE INDEX idx_pricing_route ON pricing(departure_station_id, arrival_station_id);
CREATE INDEX idx_pricing_active ON pricing(is_active);

-- =============================================
-- Triggers pour updated_at
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
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON bookings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON payments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
