/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 's2.googleusercontent.com',
      },
    ],
  },
  // Disable standalone output as it might cause issues with Vercel deployment
  // output: 'standalone',
  experimental: {
    // Enable modern features
    serverActions: true,
  },
  // Ensure proper environment handling
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL,
    NEXT_PUBLIC_WS_URL: process.env.NEXT_PUBLIC_WS_URL,
  },
  // Proper rewrites configuration for API
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: `${process.env.NEXT_PUBLIC_API_URL || '/api'}/:path*`,
      },
    ];
  },
};

export default nextConfig;
