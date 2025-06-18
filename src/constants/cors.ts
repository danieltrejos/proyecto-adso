import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

export const CORS: CorsOptions = {
  // En el origen del CORS se Reemplaza 'true' con los orígenes específicos para mayor seguridad,
  // especialmente en producción. 'true' permite CUALQUIER origen.
  origin: [
    'http://localhost:3000', // El frontend Next.js en desarrollo
    'https://proyect-front-final-production.up.railway.app', // Añade aquí la URL del frontend en producción cuando se despliegue
    'https://*.up.railway.app',
    'https://proyecto-adso-production.up.railway.app'

    // 'https://tu-aplicacion-frontend.com'
  ],
  methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Accept'],
  credentials: true,
  exposedHeaders: ['Content-Disposition', 'Content-Type', 'Content-Length']
};
