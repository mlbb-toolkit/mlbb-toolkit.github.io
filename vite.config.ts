import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  base: '/mlbb-toolkit.github.io/',
  plugins: [react()],
});
