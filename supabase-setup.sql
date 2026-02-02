-- Multi-Platform Media Downloader - Supabase Database Setup
-- Run this SQL in your Supabase SQL Editor to set up the database

-- Create the recent_downloads table with multi-platform support
CREATE TABLE IF NOT EXISTS public.recent_downloads (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    platform TEXT NOT NULL DEFAULT 'youtube',
    thumbnail_url TEXT NOT NULL,
    video_title TEXT NOT NULL,
    channel_name TEXT NOT NULL,
    resolution TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create index for faster queries (ordered by created_at)
CREATE INDEX IF NOT EXISTS idx_recent_downloads_created_at 
ON public.recent_downloads(created_at DESC);

-- Create index for platform filtering
CREATE INDEX IF NOT EXISTS idx_recent_downloads_platform 
ON public.recent_downloads(platform, created_at DESC);

-- Enable Row Level Security (RLS)
ALTER TABLE public.recent_downloads ENABLE ROW LEVEL SECURITY;

-- Create policy to allow anyone to read recent downloads
CREATE POLICY "Allow public read access" 
ON public.recent_downloads 
FOR SELECT 
USING (true);

-- Create policy to allow anyone to insert new downloads
CREATE POLICY "Allow public insert access" 
ON public.recent_downloads 
FOR INSERT 
WITH CHECK (true);

-- Enable Realtime for live updates
ALTER PUBLICATION supabase_realtime ADD TABLE public.recent_downloads;

-- Optional: Create a function to auto-delete old entries (keep only last 100)
CREATE OR REPLACE FUNCTION cleanup_old_downloads()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM public.recent_downloads
    WHERE id IN (
        SELECT id FROM public.recent_downloads
        ORDER BY created_at DESC
        OFFSET 100
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Optional: Create trigger to auto-cleanup after each insert
CREATE TRIGGER trigger_cleanup_downloads
AFTER INSERT ON public.recent_downloads
FOR EACH STATEMENT
EXECUTE FUNCTION cleanup_old_downloads();

-- Migration: Add platform column to existing table (if upgrading)
-- ALTER TABLE public.recent_downloads ADD COLUMN IF NOT EXISTS platform TEXT NOT NULL DEFAULT 'youtube';

-- Verify setup
SELECT 'Setup complete! Multi-platform table created with RLS policies and Realtime enabled.' AS status;
