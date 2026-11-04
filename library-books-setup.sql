-- ══════════════════════════════════════════════════════
--  كتب المكتبة — Supabase setup (run ONCE)
--  supabase.com → your project → SQL Editor → paste → Run
-- ══════════════════════════════════════════════════════

-- 1. Table for books uploaded from the dashboard
CREATE TABLE IF NOT EXISTS library_books (
  id            bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title_ar      text NOT NULL,
  title_en      text,
  author_ar     text,
  author_en     text,
  category      text NOT NULL DEFAULT 'arabic_reading',
  in_challenge  boolean NOT NULL DEFAULT true,
  lang          text NOT NULL DEFAULT 'arabic',
  emoji         text DEFAULT '📗',
  publisher     text,
  year          text,
  file_url      text NOT NULL,
  file_path     text,
  cover_url     text,
  cover_path    text,
  file_size     bigint,
  created_at    timestamptz DEFAULT now()
);

ALTER TABLE library_books ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "lb_select" ON library_books;
DROP POLICY IF EXISTS "lb_insert" ON library_books;
DROP POLICY IF EXISTS "lb_update" ON library_books;
DROP POLICY IF EXISTS "lb_delete" ON library_books;
CREATE POLICY "lb_select" ON library_books FOR SELECT USING (true);
CREATE POLICY "lb_insert" ON library_books FOR INSERT WITH CHECK (true);
CREATE POLICY "lb_update" ON library_books FOR UPDATE USING (true);
CREATE POLICY "lb_delete" ON library_books FOR DELETE USING (true);

-- 2. Public storage bucket for the PDFs and covers
INSERT INTO storage.buckets (id, name, public)
VALUES ('library-books', 'library-books', true)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "lb_files_read"   ON storage.objects;
DROP POLICY IF EXISTS "lb_files_upload" ON storage.objects;
DROP POLICY IF EXISTS "lb_files_delete" ON storage.objects;
CREATE POLICY "lb_files_read"   ON storage.objects FOR SELECT USING (bucket_id = 'library-books');
CREATE POLICY "lb_files_upload" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'library-books');
CREATE POLICY "lb_files_delete" ON storage.objects FOR DELETE USING (bucket_id = 'library-books');
