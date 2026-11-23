import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';

export default defineConfig(({ mode }) => ({
  plugins: [react()],
  base: mode === 'artifact' ? './' : '/hs/mechanik/',
  build: mode === 'artifact'
    ? { outDir: 'dist-artifact', assetsInlineLimit: 100_000_000, cssCodeSplit: false, modulePreload: false }
    : { outDir: 'dist' },
  test: { environment: 'node' },
}));
