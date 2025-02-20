/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        hostname: 's2.googleusercontent.com',
      },
    ],
  },
  server: {
    host: '0.0.0.0',
    port: 3000
  }
};

export default nextConfig;
