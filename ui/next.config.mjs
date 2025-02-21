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
  output: 'standalone',
};

export default nextConfig;
