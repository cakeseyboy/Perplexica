/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 's2.googleusercontent.com',
      },
    ],
  },
  poweredByHeader: false,
  generateEtags: false,
  swcMinify: true,
};

export default nextConfig;
