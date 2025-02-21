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
};

export default nextConfig;
