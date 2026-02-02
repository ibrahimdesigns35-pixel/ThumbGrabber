# ThumbGrabber — Premium Media Thumbnail Downloader

A powerful, production-ready Next.js 14 SaaS application for downloading media thumbnails from 8 major platforms with real-time global tracking and privacy-first extraction.

## ✨ Features

- 🎯 **Multi-Platform Support** - Download thumbnails from YouTube, Vimeo, TikTok, Instagram, LinkedIn, Twitter/X, Twitch, and Facebook
- 🤖 **Smart URL Detection** - Automatically detects platform from any URL
- 🔴 **Live Global Feed** - See recent downloads from all users in real-time via Supabase Realtime
- 🎨 **Premium SaaS UI** - Beautiful dark theme with glassmorphism and platform-specific color coding
- ⚡ **Lightning Fast** - Built with Next.js 14 App Router for optimal performance
- 🛡️ **Robust Error Handling** - Graceful degradation when services are unavailable
- 📱 **Fully Responsive** - Works perfectly on desktop, tablet, and mobile
- 🔍 **Platform-Specific Extraction** - Optimized extractors for each platform

## 🚀 Quick Start

### Prerequisites

- Node.js 18 or higher
- npm or yarn
- Supabase account (free tier works perfectly)

### Installation

1. **Clone the repository**
   ```bash
   cd "c:\Users\pc\Downloads\yt thumbnail downloader"
   ```

2. **Install dependencies**
   ```powershell
   powershell -ExecutionPolicy Bypass -Command "npm install"
   ```

3. **Set up Supabase**
   
   a. Create a free account at [supabase.com](https://supabase.com)
   
   b. Create a new project
   
   c. Go to **Project Settings > API** and copy:
      - Project URL
      - anon/public key
   
   d. Run the SQL setup script:
      - Open **SQL Editor** in Supabase
      - Copy contents from `supabase-setup.sql`
      - Execute the script

4. **Configure environment variables**
   ```powershell
   # Copy the example file
   Copy-Item .env.example .env.local
   
   # Edit .env.local and add your Supabase credentials
   ```

5. **Run the development server**
   ```powershell
   powershell -ExecutionPolicy Bypass -Command "npm run dev"
   ```

6. **Open your browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

## 🏗️ Project Structure

```
yt-thumbnail-downloader/
├── app/
│   ├── layout.tsx          # Root layout with metadata
│   ├── page.tsx            # Home page
│   └── globals.css         # Global styles
├── components/
│   ├── Header.tsx          # Navigation header
│   ├── Hero.tsx            # Main input and multi-platform detection
│   ├── ThumbnailCard.tsx   # Individual thumbnail card
│   ├── RecentDownloads.tsx # Live global feed with platform badges
│   ├── PlatformBadge.tsx   # Platform icon/badge component
│   └── Footer.tsx          # Footer component
├── lib/
│   ├── platform-detector.ts # Smart URL detection for all platforms
│   ├── extractors/
│   │   ├── base.ts         # Base extractor interface
│   │   ├── youtube.ts      # YouTube extractor
│   │   ├── vimeo.ts        # Vimeo extractor
│   │   ├── tiktok.ts       # TikTok extractor
│   │   ├── instagram.ts    # Instagram extractor
│   │   ├── linkedin.ts     # LinkedIn extractor
│   │   ├── twitter.ts      # Twitter/X extractor
│   │   ├── twitch.ts       # Twitch extractor
│   │   ├── facebook.ts     # Facebook extractor
│   │   └── index.ts        # Extractor factory
│   ├── supabase.ts         # Supabase client with validation
│   ├── youtube.ts          # Legacy YouTube utilities
│   └── utils.ts            # General utilities
├── .env.local              # Environment variables (create from .env.example)
├── .env.example            # Example environment file
└── supabase-setup.sql      # Database setup script
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `NEXT_PUBLIC_SUPABASE_URL` | Your Supabase project URL | Yes |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your Supabase anon/public key | Yes |

### Supabase Setup

The application requires a `recent_downloads` table with the following schema:

```sql
CREATE TABLE recent_downloads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    thumbnail_url TEXT NOT NULL,
    video_title TEXT NOT NULL,
    channel_name TEXT NOT NULL,
    resolution TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Important:** The complete setup script in `supabase-setup.sql` includes:
- Table creation
- Indexes for performance
- Row Level Security (RLS) policies
- Realtime subscription enablement
- Auto-cleanup trigger (keeps last 100 downloads)

## 🎯 Usage

1. **Paste any media URL** from supported platforms:
   - **YouTube**: `https://www.youtube.com/watch?v=VIDEO_ID` or `https://youtu.be/VIDEO_ID`
   - **Vimeo**: `https://vimeo.com/123456789`
   - **TikTok**: `https://www.tiktok.com/@user/video/123456789`
   - **Instagram**: `https://www.instagram.com/p/ABC123/` or `https://www.instagram.com/reel/ABC123/`
   - **LinkedIn**: `https://www.linkedin.com/posts/...`
   - **Twitter/X**: `https://twitter.com/user/status/123456789` or `https://x.com/user/status/123456789`
   - **Twitch**: `https://www.twitch.tv/videos/123456789` or `https://www.twitch.tv/channel`
   - **Facebook**: `https://www.facebook.com/watch/?v=123456789`

2. **Click "GRAB MEDIA"** - Platform is auto-detected and media is extracted

3. **Choose your resolution** and click "DOWNLOAD"

4. **Watch the live feed** update with your download and others globally, with platform badges

## 🛠️ Development

### Available Scripts

```powershell
# Development server
powershell -ExecutionPolicy Bypass -Command "npm run dev"

# Production build
powershell -ExecutionPolicy Bypass -Command "npm run build"

# Start production server
powershell -ExecutionPolicy Bypass -Command "npm start"

# Lint code
powershell -ExecutionPolicy Bypass -Command "npm run lint"
```

### Key Features Implemented

✅ **Environment Validation** - Runtime checks for Supabase credentials  
✅ **Error Boundaries** - Graceful error handling throughout the app  
✅ **Timeout Handling** - 10-second timeout for YouTube API requests  
✅ **Retry Logic** - Automatic retry for failed downloads  
✅ **Graceful Degradation** - App works even if database is unavailable  
✅ **Cross-Browser Support** - Tested download functionality across browsers  
✅ **Realtime Subscriptions** - Live updates with automatic reconnection  
✅ **Connection Status** - Visual indicators for database connectivity  

## 🐛 Troubleshooting

### PowerShell Execution Policy Error

If you see "running scripts is disabled on this system":
```powershell
powershell -ExecutionPolicy Bypass -Command "npm run dev"
```

### Blank Page / App Won't Load

1. Check browser console for errors
2. Verify `.env.local` exists and has valid credentials
3. Ensure Supabase setup script was run
4. Check that port 3000 is available

### Downloads Not Appearing in Live Feed

1. Verify Supabase Realtime is enabled (check `supabase-setup.sql`)
2. Check RLS policies allow public insert/select
3. Look for errors in browser console
4. Note: Downloads still work even if database is unavailable

### YouTube Video Not Found

- Ensure the video is public (not private or deleted)
- Try a different video URL
- Check your internet connection

## 📦 Deployment

### Vercel (Recommended)

1. Push your code to GitHub
2. Import project in [Vercel](https://vercel.com)
3. Add environment variables in Vercel dashboard
4. Deploy!

### Other Platforms

The app works on any platform that supports Next.js 14:
- Netlify
- Railway
- Render
- AWS Amplify

## 🔒 Security

- ✅ Row Level Security (RLS) enabled on Supabase
- ✅ Environment variables for sensitive data
- ✅ No server-side API keys exposed
- ✅ CORS-safe download implementation

## 📝 License

This project is open source and available for personal and commercial use.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests

## 💡 Tips

- **4K/5K thumbnails** may not be available for all videos
- **Live feed** shows the last 10 downloads globally
- **Downloads** are saved to your browser's default download folder
- **App works offline** for downloading (live feed requires connection)

## 🎨 Tech Stack

- **Framework:** Next.js 14 (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS
- **Database:** Supabase (PostgreSQL)
- **Realtime:** Supabase Realtime
- **Icons:** Lucide React
- **Deployment:** Vercel-ready

---

**Built with ❤️ for the YouTube creator community**
