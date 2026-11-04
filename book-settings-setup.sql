-- ══════════════════════════════════════════════════════
--  Show/hide + تحدي القراءة العربي for all books — run ONCE
--  supabase.com → your project → SQL Editor → paste → Run
--  (Adds a new table and one new column. Existing data is kept.)
-- ══════════════════════════════════════════════════════

-- 1. Settings for the original books (from books-data.js)
CREATE TABLE IF NOT EXISTS book_settings (
  book_id       integer PRIMARY KEY,
  in_challenge  boolean,                 -- empty = use the default list
  hidden        boolean NOT NULL DEFAULT false,
  updated_at    timestamptz DEFAULT now()
);

ALTER TABLE book_settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "bs_select" ON book_settings FOR SELECT USING (true);
CREATE POLICY "bs_insert" ON book_settings FOR INSERT WITH CHECK (true);
CREATE POLICY "bs_update" ON book_settings FOR UPDATE USING (true);

-- 2. Show/hide for books uploaded from the dashboard
ALTER TABLE library_books ADD COLUMN IF NOT EXISTS hidden boolean NOT NULL DEFAULT false;
