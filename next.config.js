/** @type {import('next').NextConfig} */
const nextConfig = {
    images: {
        remotePatterns: [
            { protocol: 'https', hostname: 'img.youtube.com' },
            { protocol: 'https', hostname: 'i.ytimg.com' },
            { protocol: 'https', hostname: 'i.vimeocdn.com' },
            { protocol: 'https', hostname: 'p16-sign-va.tiktokcdn.com' },
            { protocol: 'https', hostname: 'scontent.cdninstagram.com' },
            { protocol: 'https', hostname: 'i.pravatar.cc' },
        ],
    },
}

module.exports = nextConfig
