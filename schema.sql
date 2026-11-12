
-- ==========================================
-- 1. Таблица пользователей
-- ==========================================
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY, -- Заменено SERIAL на IDENTITY
    login VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fio VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'client' CHECK (role IN ('client', 'admin')),
    created_at DATETIME DEFAULT GETDATE() -- Заменено TIMESTAMP на DATETIME, CURRENT_TIMESTAMP на GETDATE()
);
GO

-- ==========================================
-- 2. Таблица услуг
-- ==========================================
CREATE TABLE services (
    id INT IDENTITY(1,1) PRIMARY KEY, -- Заменено SERIAL
    title VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    duration INT NOT NULL 
);
GO

-- ==========================================
-- 3. Таблица заявок (записей)
-- ==========================================
CREATE TABLE appointments (
    id INT IDENTITY(1,1) PRIMARY KEY, -- Заменено SERIAL
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    service_id INT NOT NULL REFERENCES services(id) ON DELETE NO ACTION, -- RESTRICT в SQL Server работает как NO ACTION
    appointment_date DATETIME NOT NULL, -- Заменено TIMESTAMP
    status VARCHAR(20) DEFAULT 'new' CHECK (status IN ('new', 'confirmed', 'completed', 'cancelled')),
    created_at DATETIME DEFAULT GETDATE(), -- Заменено TIMESTAMP
    updated_at DATETIME DEFAULT GETDATE()  -- Заменено TIMESTAMP
);
GO

-- ==========================================
-- 4. Индексы для оптимизации
-- ==========================================
CREATE INDEX idx_users_login ON users(login);
CREATE INDEX idx_appointments_user_id ON appointments(user_id);
CREATE INDEX idx_appointments_status ON appointments(status);
GO

-- ==========================================
-- 5. Добавим тестовые данные (Услуги)
-- ==========================================
INSERT INTO services (title, price, duration) VALUES 
('Женская стрижка', 2500.00, 60),
('Маникюр с покрытием', 3000.00, 90),
('Окрашивание волос', 6000.00, 180);
GO