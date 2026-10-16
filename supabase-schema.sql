-- ============================================================
-- SKEMA DATABASE SUPABASE UNTUK FOKUS POMODORO
-- ============================================================
-- Jalankan skrip ini di SQL Editor di dashboard Supabase milikmu:
-- https://supabase.com/dashboard/project/_/sql

-- 1. Tabel Pengguna (fokus_users)
CREATE TABLE IF NOT EXISTS public.fokus_users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role TEXT DEFAULT 'user' NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  last_login TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Tabel Data Tugas & Sesi Pengguna (fokus_user_data)
CREATE TABLE IF NOT EXISTS public.fokus_user_data (
  username TEXT PRIMARY KEY REFERENCES public.fokus_users(username) ON DELETE CASCADE,
  tasks JSONB DEFAULT '[]'::jsonb NOT NULL,
  sessions JSONB DEFAULT '[]'::jsonb NOT NULL,
  goal INTEGER DEFAULT 120 NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Row Level Security (RLS) & Policies
ALTER TABLE public.fokus_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fokus_user_data ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public select fokus_users" ON public.fokus_users;
CREATE POLICY "Public select fokus_users" ON public.fokus_users FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public insert fokus_users" ON public.fokus_users;
CREATE POLICY "Public insert fokus_users" ON public.fokus_users FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Public update fokus_users" ON public.fokus_users;
CREATE POLICY "Public update fokus_users" ON public.fokus_users FOR UPDATE USING (true);

DROP POLICY IF EXISTS "Public delete fokus_users" ON public.fokus_users;
CREATE POLICY "Public delete fokus_users" ON public.fokus_users FOR DELETE USING (true);

DROP POLICY IF EXISTS "Public all fokus_user_data" ON public.fokus_user_data;
CREATE POLICY "Public all fokus_user_data" ON public.fokus_user_data FOR ALL USING (true);

-- 4. Akun Admin Default (usn: admin, pw: admin123)
-- Hash SHA-256 dari 'admin123:fokus_salt_2026'
INSERT INTO public.fokus_users (username, password_hash, role)
VALUES ('admin', '252520c9eedc60aaa109031d54893a70a095fdd8e117ea8d89895727363b4c5e', 'admin')
ON CONFLICT (username) DO NOTHING;

INSERT INTO public.fokus_user_data (username, tasks, sessions, goal)
VALUES ('admin', '[]'::jsonb, '[]'::jsonb, 120)
ON CONFLICT (username) DO NOTHING;
