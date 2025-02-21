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
  // Production settings
  distDir: '.next',
  // Disable standalone output as it might cause issues with Vercel deployment
  // output: 'standalone',
  // Enable modern features
  experimental: {
    serverActions: true,
  },
  // Ensure proper environment handling
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL,
    NEXT_PUBLIC_WS_URL: process.env.NEXT_PUBLIC_WS_URL,
  },
  // Handle all routes properly
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: `${process.env.NEXT_PUBLIC_API_URL || '/api'}/:path*`,
      },
    ];
  },
  // Ensure proper handling of 404s
  async redirects() {
    return [];
  },
  // Ensure proper trailing slashes
  trailingSlash: false,
};

export default nextConfig;
