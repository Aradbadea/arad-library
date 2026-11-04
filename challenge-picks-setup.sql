-- ══════════════════════════════════════════════════════
--  Original books: تحدي القراءة العربي on/off — run ONCE
--  supabase.com → your project → SQL Editor → paste → Run
--  (Only creates a new table. It does not touch existing data.)
-- ══════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS challenge_picks (
  book_id       integer PRIMARY KEY,
  in_challenge  boolean NOT NULL DEFAULT true,
  updated_at    timestamptz DEFAULT now()
);

ALTER TABLE challenge_picks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "cp_select" ON challenge_picks FOR SELECT USING (true);
CREATE POLICY "cp_insert" ON challenge_picks FOR INSERT WITH CHECK (true);
CREATE POLICY "cp_update" ON challenge_picks FOR UPDATE USING (true);
