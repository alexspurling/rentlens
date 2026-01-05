import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		port: Number(process.env.PORT) || 3000,
		strictPort: false,
		host: true
	},
	preview: {
		port: Number(process.env.PORT) || 4000,
		strictPort: false,
		host: true
	}
});
