# ThumbGrabber - Walkthrough

ThumbGrabber is a premium, production-ready YouTube thumbnail downloader built with Next.js 14, Tailwind CSS, and Supabase.

## Key Features
- **Instant Extraction**: Parse any YouTube URL (short or long form) and extract all available thumbnail resolutions.
- **Multiple Resolutions**: Support for 4K (MaxRes), HD (SD), High, Medium, and Default quality.
- **Live History**: Real-time download history powered by Supabase Realtime.
- **Modern UI**: Dark SaaS theme with cyan accents, glassmorphism, and smooth animations.
- **Responsive Design**: Fully optimized for mobile, tablet, and desktop.

## Tech Stack
- **Framework**: Next.js 14 (App Router)
- **Styling**: Tailwind CSS + Lucide Icons
- **Database**: Supabase (PostgreSQL + Realtime)
- **Fonts**: Poppins (Headings) & Inter (Body)

## Project Structure
- `lib/supabase.ts`: Supabase client configuration.
- `lib/youtube.ts`: YouTube URL parsing and metadata fetching.
- `components/Hero.tsx`: Main input and thumbnail display logic.
- `components/RecentDownloads.tsx`: Real-time history feed.
- `components/ThumbnailCard.tsx`: Individual resolution card with download trigger.

## Supabase Database Setup
To ensure the "Recent Downloads" section works correctly, create the following table in your Supabase SQL Editor:

```sql
CREATE TABLE IF NOT EXISTS recent_downloads (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  thumbnail_url TEXT NOT NULL,
  video_title TEXT NOT NULL,
  channel_name TEXT NOT NULL,
  resolution TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Enable Realtime for this table
ALTER PUBLICATION supabase_realtime ADD TABLE recent_downloads;
```

## Deployment Steps
1. **Supabase Setup**: Follow the SQL instructions above to create the table and enable Realtime.
2. **Environment Variables**: Create a `.env.local` file (or set in your hosting provider like Vercel/Netlify) with the following:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=your_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
   ```
3. **Build**: Run `npm run build` to ensure everything is production-ready.
4. **Deploy**: Connect your repo to Vercel for the best Next.js experience.

## Verification
- [x] **Realtime**: Tested and confirmed via Supabase Channel API.
- [x] **Responsive**: Tailored with mobile-first Tailwind utilities.
- [x] **SEO**: Meta tags and Open Graph data included.
- [x] **Error Handling**: YT URL validation and missing thumbnail fallbacks implemented.

ThumbGrabber is now fully production-ready and ready for its first user!
