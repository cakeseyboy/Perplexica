/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  distDir: '.next',
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 's2.googleusercontent.com',
      },
    ],
  },
  experimental: {
    outputFileTracingRoot: process.env.NODE_ENV === "production" ? "/app" : undefined,
    outputStandalone: true,
  },
  poweredByHeader: false,
  generateEtags: false,
};

export default nextConfig;
